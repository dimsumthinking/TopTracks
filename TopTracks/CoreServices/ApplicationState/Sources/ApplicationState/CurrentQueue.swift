import Model
import MusicKit

public class CurrentQueue {
  public static let shared = CurrentQueue()
}

extension CurrentQueue {
  func refillQueueIfNeeded() {
    let player = ApplicationMusicPlayer.shared
    let entries = player.queue.entries
    if let currentEntry = player.queue.currentEntry,
       let index = entries.firstIndex(of: currentEntry),
       entries.distance(from: index, to: entries.endIndex) < 3 {
      refillQueue()
    }
  }
  
  private func refillQueue() {
    guard let currentStation = CurrentStation.shared.topTracksStation else { return }
    let player = ApplicationMusicPlayer.shared
    Task {
      try await player.queue.insert(currentStation.nextHour(),
                                    position: .tail)
    }
  }
}


extension CurrentQueue {
  public func playStation(_ station: TopTracksStation) async throws {
    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: station.nextHour())
    try await setUpPlayer()
    await MainActor.run {
      CurrentStation.shared.setStation(to: station)
    }
  }
  
  private func setUpPlayer() async throws {
    try await ApplicationMusicPlayer.shared.prepareToPlay()
    try await ApplicationMusicPlayer.shared.play()
  }
}

extension CurrentQueue {
  public func stopPlayingDeletedStation(_ station: TopTracksStation) {
    guard CurrentStation.shared.topTracksStation == station else { return }
    stopPlayingStation()
  }
  
  public func stopPlayingStation() {
    CurrentStation.shared.noStationSelected()
    ApplicationMusicPlayer.shared.stop()
    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: [Song]())
    ApplicationMusicPlayer.shared.queue.currentEntry = nil
    
  }
}
