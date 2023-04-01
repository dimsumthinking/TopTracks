import Model

public class CurrentActivity {
  public static let shared = CurrentActivity()
  private var continuation: AsyncStream<TopTracksAppActivity>.Continuation?
  
  lazy public private(set) var activities = AsyncStream(TopTracksAppActivity.self) { continuation in
    self.continuation = continuation
  }
}

extension CurrentActivity {
  public func beginCreating() {
    continuation?.yield(.creating)
//    currentActivity = .creating
  }
  
  public func endCreating() {
//    currentActivity = .enjoying
    continuation?.yield(.enjoying)
    restartPlayer()
  }
  
  public func beginStationgSongList(for topTracksStation: TopTracksStation) {
//    currentActivity = .viewingOrEditing(topTracksStation: topTracksStation)
    continuation?.yield(.viewingOrEditing(topTracksStation: topTracksStation))
  }
  
  public func endStationSongList() {
//    currentActivity = .enjoying
    continuation?.yield(.enjoying)
    restartPlayer()
  }
  
  private func restartPlayer() {
//    guard (ApplicationMusicPlayer.shared.state.playbackStatus != .paused &&
//           ApplicationMusicPlayer.shared.state.playbackStatus != .playing) else {return}
//    if let cachedSong  {
//      currentSong = cachedSong
//      ApplicationMusicPlayer.shared.queue =  ApplicationMusicPlayer.Queue(for: [cachedSong])
//      refillQueue()
//      if let songTime {
//        ApplicationMusicPlayer.shared.playbackTime = songTime
//      }
//      Task {
//        try await setUpPlayer()
//      }
//    } else {
//      currentSong = nil
//      currentStation = nil
//    }
//    cachedSong = nil
//    songTime = nil
  }
  

}
