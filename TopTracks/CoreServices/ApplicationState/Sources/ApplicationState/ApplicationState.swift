import Combine
import Model
import Foundation
import MusicKit


public class ApplicationState: ObservableObject {
  public static var shared = ApplicationState()
  @Published public private(set) var currentActivity: TopTracksAppActivity = .playing
  @Published public private(set) var currentStation: TopTracksStation?
  @Published public private(set) var currentSong: Song?
}

extension ApplicationState {
  public func setStation(to station: TopTracksStation) {
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
  
  public func noStationSelected() {
    currentStation = nil
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
