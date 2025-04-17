import Model
import MediaPlayer
import MusicKit
import Observation

@MainActor
@Observable
public class CurrentActivity {
  public static let shared = CurrentActivity()
  private var backgroundCache: BackgroundCache?
  public var appActivity: TopTracksAppActivity = .enjoying
}

extension CurrentActivity {
  public func beginCreating() {
    appActivity = .creating
  }
  
  public func endCreating() {
    appActivity = .enjoying
    restartPlayer()
  }
  

  
  public func beginStationSongList(for topTracksStation: TopTracksStation) {
    backgroundCache = BackgroundCache(currentSong: CurrentSong.shared.nowPlaying,
                                      currentStation: CurrentStation.shared.nowPlaying)
    appActivity = .viewingOrEditing(topTracksStation: topTracksStation)
  }
  
  public func endStationSongList() {
    appActivity = .enjoying
    restartPlayer()
  }
  
  private func restartPlayer() {
//    #if !os(macOS)
    guard (ApplicationMusicPlayer.shared.state.playbackStatus != .paused &&
           ApplicationMusicPlayer.shared.state.playbackStatus != .playing) else {return}
    if let cachedSong = backgroundCache?.currentSong?.song {
      let playbackTime = backgroundCache?.currentTime
      ApplicationMusicPlayer.shared.queue =  ApplicationMusicPlayer.Queue(for: [cachedSong])
      CurrentQueue.shared.refillQueue()
      Task {
        try await CurrentQueue.shared.setUpPlayer(toPlayAt: playbackTime)
      }
    } else {
      CurrentSong.shared.nowPlaying = nil
      CurrentStation.shared.nowPlaying = nil
    }
    backgroundCache = nil
//    #endif
  }
}

