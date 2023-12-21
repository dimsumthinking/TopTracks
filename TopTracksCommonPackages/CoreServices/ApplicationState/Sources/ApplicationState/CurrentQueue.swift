import Model
import MusicKit
import Foundation
import Constants

public class CurrentQueue {
  public static let shared = CurrentQueue()
  private var sleepTimer: SleepTimer?
}

extension CurrentQueue {
  func refillQueueIfNeeded() {
//    #if !os(macOS)
    let player = ApplicationMusicPlayer.shared
    let entries = player.queue.entries
    if let currentEntry = player.queue.currentEntry,
       let index = entries.firstIndex(of: currentEntry),
       entries.distance(from: index, to: entries.endIndex) < 3 {
      refillQueue()
    }
//    #endif
  }
  
  func refillQueue() {
//    #if !os(macOS)
    guard let currentStation = CurrentStation.shared.nowPlaying else { return }
    let player = ApplicationMusicPlayer.shared
    Task {
      try await player.queue.insert(currentStation.nextHour(),
                                    position: .tail)
    }
//    #endif
  }
}


extension CurrentQueue {
  public func playStation(_ station: TopTracksStation) async throws {
//    #if !os(macOS)
    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: station.nextHour())
    let cachedStation = StationChangeCache(currentSong: CurrentSong.shared.song,
                                           currentStation: CurrentStation.shared.nowPlaying, 
                                           currentTime: ApplicationMusicPlayer.shared.playbackTime)
    do {
      try await setUpPlayer()
      try await MainActor.run {
        try CurrentStation.shared.setStation(to: station)
      }
    } catch {
      NotificationCenter.default.post(name: Constants.stationWontPlayNotification,
                                      object: self,
                                      userInfo: [Constants.stationThatWontPlayKey: station.name])
      restartPlayer(cache: cachedStation)
    }

//    #endif
  }
  
  private func restartPlayer(cache: StationChangeCache) {
    if let cachedSong = cache.currentSong,
       let cachedStation = cache.currentStation {
      let playbackTime = cache.currentTime
      ApplicationMusicPlayer.shared.queue =  ApplicationMusicPlayer.Queue(for: [cachedSong])
      CurrentQueue.shared.refillQueue()
      Task {
        try await CurrentQueue.shared.setUpPlayer(toPlayAt: playbackTime)
        try await MainActor.run {
          try CurrentStation.shared.setStation(to: cachedStation)
        }
      }
    }
  }
  
  public func playRandomStation(_ stations: [TopTracksStation]) async throws  {
    guard let randomStation = stations.randomElement() else { return }
    try await playStation(randomStation)
  }
  
  func setUpPlayer(toPlayAt playbackTime: TimeInterval? = nil) async throws {
//    #if !os(macOS)
    try await ApplicationMusicPlayer.shared.prepareToPlay()
    if let playbackTime {
      ApplicationMusicPlayer.shared.playbackTime = playbackTime
    }
    try await ApplicationMusicPlayer.shared.play()
//    #endif
  }
}

extension CurrentQueue {
  public func stopPlayingDeletedStation(_ station: TopTracksStation) {
    guard CurrentStation.shared.nowPlaying == station else { return }
    stopPlayingStation()
  }
  
  public func stopPlayingStation() {
//    #if !os(macOS)
    CurrentStation.shared.noStationSelected()
    ApplicationMusicPlayer.shared.stop()
    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: [Song]())
    ApplicationMusicPlayer.shared.queue.currentEntry = nil
//    #endif
  }
}

extension CurrentQueue {
  public var sleepTimerIsSet: Bool {
    sleepTimer != nil
  }
  
  public var sleepsAfterSong: Bool {
    sleepTimer?.afterSong ?? false
  }
  
  public var endTime: Date? {
    sleepTimer?.endTime
  }
  
  public func sleepAfter(timeInterval: TimeInterval,
                         finishSong: Bool = false) {
    sleepTimer = SleepTimer(for: timeInterval,
                            finishSong: finishSong)
    Task {
      await sleepTimer?.sleep()
      sleepTimer = nil
    }
  }
  
  public func cancelTimer() {
    sleepTimer = nil
  }
}
