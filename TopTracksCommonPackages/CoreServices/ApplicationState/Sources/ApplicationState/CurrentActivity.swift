import Model
import MediaPlayer
import MusicKit
import Observation

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
  
  #if os(tvOS)
  public func beginImporting() {
    appActivity = .importing(url: URL(string: "fictionalURL")!)
  }
  
  public func endImporting() {
    appActivity = .enjoying
  }
  #else
  
  public func beginImporting(url: URL) {
    backgroundCache = BackgroundCache(currentSong: CurrentSong.shared.song,
                                      currentStation: CurrentStation.shared.nowPlaying)
    appActivity = .importing(url: url)
  }
  
  public func endImporting() {
    appActivity = .enjoying
    restartPlayer()
  }
  #endif
  
  public func beginStationSongList(for topTracksStation: TopTracksStation) {
    backgroundCache = BackgroundCache(currentSong: CurrentSong.shared.song,
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
    if let cachedSong = backgroundCache?.currentSong {
      let playbackTime = backgroundCache?.currentTime
      ApplicationMusicPlayer.shared.queue =  ApplicationMusicPlayer.Queue(for: [cachedSong])
      CurrentQueue.shared.refillQueue()
      Task {
        try await CurrentQueue.shared.setUpPlayer(toPlayAt: playbackTime)
      }
    } else {
      CurrentSong.shared.song = nil
      CurrentStation.shared.nowPlaying = nil
    }
    backgroundCache = nil
//    #endif
  }
}

//
//import Model
//import MediaPlayer
//import MusicKit
//
//public class CurrentActivity {
//  public static let shared = CurrentActivity()
//  private var backgroundCache: BackgroundCache?
//  private var continuation: AsyncStream<TopTracksAppActivity>.Continuation?
//  
//  lazy public private(set) var activities = AsyncStream(TopTracksAppActivity.self) { continuation in
//    self.continuation = continuation
//  }
//}
//
//extension CurrentActivity {
//  public func beginCreating() {
//    continuation?.yield(.creating)
//  }
//  
//  public func endCreating() {
//    continuation?.yield(.enjoying)
//    restartPlayer()
//  }
//  
//  #if os(tvOS)
//  public func beginImporting() {
//    continuation?.yield(.importing(url: URL(string: "fictionalURL")!))
//  }
//  
//  public func endImporting() {
//    continuation?.yield(.enjoying)
//  }
//  #else
//  
//  public func beginImporting(url: URL) {
//    backgroundCache = BackgroundCache(currentSong: CurrentSong.shared.song,
//                                      currentStation: CurrentStation.shared.topTracksStation)
//    continuation?.yield(.importing(url: url))
//  }
//  
//  public func endImporting() {
//    continuation?.yield(.enjoying)
//    restartPlayer()
//  }
//  #endif
//  
//  public func beginStationgSongList(for topTracksStation: TopTracksStation) {
//    backgroundCache = BackgroundCache(currentSong: CurrentSong.shared.song,
//                                      currentStation: CurrentStation.shared.topTracksStation)
//    continuation?.yield(.viewingOrEditing(topTracksStation: topTracksStation))
//  }
//  
//  public func endStationSongList() {
//    continuation?.yield(.enjoying)
//    restartPlayer()
//  }
//  
//  private func restartPlayer() {
//    #if !os(macOS)
//    guard (ApplicationMusicPlayer.shared.state.playbackStatus != .paused &&
//           ApplicationMusicPlayer.shared.state.playbackStatus != .playing) else {return}
//    if let cachedSong = backgroundCache?.currentSong {
//      let playbackTime = backgroundCache?.currentTime
//      ApplicationMusicPlayer.shared.queue =  ApplicationMusicPlayer.Queue(for: [cachedSong])
//      CurrentQueue.shared.refillQueue()
//      Task {
//        try await CurrentQueue.shared.setUpPlayer(toPlayAt: playbackTime)
//      }
//    } else {
//      CurrentSong.shared.song = nil
//      CurrentStation.shared.topTracksStation = nil
//    }
//    backgroundCache = nil
//    #endif
//  }
//}
