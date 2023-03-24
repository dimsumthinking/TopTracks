import Combine
import Model
import Foundation
import MusicKit


public class ApplicationState: ObservableObject {
  public static var shared = ApplicationState()
  @Published public private(set) var currentActivity: TopTracksAppActivity = .playing
  @Published public private(set) var currentStation: TopTracksStation?
  @Published public private(set) var currentSong: Song?
  public var endTime: Date?
  private var sleepTimer: Task<Void, Error>?
  private var queueCache: ApplicationMusicPlayer.Queue?
  private var cachedSong: Song?
  private var songTime: TimeInterval?
  
  init() {
    Task {
      for await _ in NotificationCenter.default.notifications(named: Notification.Name("PreviewPlayerBegan")) {
        cachedSong = currentSong
        songTime = ApplicationMusicPlayer.shared.playbackTime
      }
    }
  }
}

extension ApplicationState {
   func setStation(to station: TopTracksStation) {
    station.lastTouched = Date()
    do {
      try sharedViewContext.save()
    }
    catch {
      sharedViewContext.rollback()
      print("Couldn't save station starting to play")
    }
    currentStation = station
  }
  
  public func playStation(_ station: TopTracksStation) async throws {
    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: station.nextHour())
    try await setUpPlayer()
    await MainActor.run {
      setStation(to: station)
    }
  }
  
  private func setUpPlayer() async throws {
    try await ApplicationMusicPlayer.shared.prepareToPlay()
    try await ApplicationMusicPlayer.shared.play()
  }
  
  public func noStationSelected() {
    currentStation = nil
    ApplicationMusicPlayer.shared.stop()
    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: [Song]())
    ApplicationMusicPlayer.shared.queue.currentEntry = nil
  }
}

extension ApplicationState {
  public func setSong(to song: TopTracksSong) {
    song.markPlayed()
    currentSong = song.song
  }
  
  public func setCurrentSong(using entry: ApplicationMusicPlayer.Queue.Entry) {
    guard let item = entry.item else {return}
    switch item {
    case .song(let song):
      _ = song.anyMatchingTopTracksSong
      currentSong = song
    default:
      print("Entry is not a song")
    }
    refillQueue()
  }
  
  public func noSongSelected() {
    currentSong = nil
  }
}

extension ApplicationState {
  public func beginCreating() {
    currentActivity = .creating
  }
  
  public func endCreating() {
    currentActivity = .playing
    restartPlayer()
  }
  
  public func beginStationgSongList(for topTracksStation: TopTracksStation) {
    currentActivity = .viewingOrEditing(topTracksStation: topTracksStation)
  }
  
  public func endStationSongList() {
    currentActivity = .playing
    restartPlayer()
  }
  
  private func restartPlayer() {
    guard (ApplicationMusicPlayer.shared.state.playbackStatus != .paused &&
           ApplicationMusicPlayer.shared.state.playbackStatus != .playing) else {return}
    if let cachedSong  {
      currentSong = cachedSong
      ApplicationMusicPlayer.shared.queue =  ApplicationMusicPlayer.Queue(for: [cachedSong])
      refillQueue()
      if let songTime {
        ApplicationMusicPlayer.shared.playbackTime = songTime
      }
      Task {
        try await setUpPlayer()
      }
    } else {
      currentSong = nil
      currentStation = nil
    }
    cachedSong = nil
    songTime = nil
  }
  

}

extension ApplicationState {
  private func refillQueue() {
    guard let currentStation else { return }
    let player = ApplicationMusicPlayer.shared
    let entries = player.queue.entries
    if let currentEntry = player.queue.currentEntry,
       let index = entries.firstIndex(of: currentEntry),
        entries.distance(from: index, to: entries.endIndex) < 3 {
      Task {
        try await player.queue.insert(currentStation.nextHour(),
                                      position: .tail)
      }
    }
  }
}

extension ApplicationState {
  public func sleepAfter(timeInterval: TimeInterval,
                         andSongPlayingThen: Bool = false) {
    endTime = Date().addingTimeInterval(timeInterval)
    sleepTimer?.cancel()
    sleepTimer = Task {
      try? await Task.sleep(for: .seconds(10)) // timeInterval
      try Task.checkCancellation()
      if andSongPlayingThen {
        await pauseAfterCurrentSong()
      } else {
        ApplicationMusicPlayer.shared.pause()
      }
      endTime = nil
    }
  }
  
  private func pauseAfterCurrentSong() async {
    if let duration = currentSong?.duration {
      try? await Task.sleep(for: .seconds(duration - ApplicationMusicPlayer.shared.playbackTime - 1))
    }
    ApplicationMusicPlayer.shared.pause()
  }
  
  public func cancelTimer() {
    endTime = nil
    sleepTimer?.cancel()
  }
}

extension ApplicationState {
  public var currentRatingIconName: String {
    currentSong?.anyMatchingTopTracksSong?.songRating.icon ?? "heart"
  }
  
  public var currentRatingName: String {
    currentSong?.anyMatchingTopTracksSong?.songRating.name ?? "It's ok"
  }
  
  public func changeRating(to rating: SongRating) {
    currentSong?.changeRatingForEveryMatchingTopTracksSong(to: rating)
  }
  
  public func removeCurrentSong() {
//    currentSong?.moveEveryMatchingTopTracksSong(to: .removed)
    guard let currentStation,
          let currentSong else { return }
    currentStation.remove(song: currentSong)
  }
  public var canShowRating: Bool {
    guard let currentStation else { return false }
    return !currentStation.isChart
  }
  
}


