import MusicKit
import AudioToolbox
import Model
import ApplicationState

let stationSongPlayer = StationSongPlayer()

class StationSongPlayer {
  private var player = ApplicationMusicPlayer.shared
  private var currentPlaybackTime: TimeInterval = 0
  fileprivate init(){}
}

extension StationSongPlayer {
  
//  func pause(_ station: TopTracksStation? = nil,
//             at song: Song? = nil) {
//    player.pause()
//  }
//
//  var state: ApplicationMusicPlayer.State {
//    ApplicationMusicPlayer.shared.state
//  }
//
//  func prepareToPlay() {
//    Task {
//      try await player.prepareToPlay()
//    }
//  }
  
  func play(_ station: TopTracksStation) async throws {
    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: station.nextHour())
    try await player.prepareToPlay()
    try await player.play()
  }
  
  
//  func restart() async throws {
//    try await player.play()
//  }
  
//  func clearPlayer() {
//    ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: [Song]())
//    ApplicationMusicPlayer.shared.queue.currentEntry = nil
//  }
//  func skipToNextEntry() async throws {
//    try await player.skipToNextEntry()
//  }
//  func skipToPreviousEntry() async throws {
//    if player.playbackTime < 3 {
//      try await player.skipToPreviousEntry()
//    } else {
//      player.restartCurrentEntry()
//    }
//  }
//  var isPlaying: Bool {
//    player.state.playbackStatus == .playing
//  }
  
  
}


