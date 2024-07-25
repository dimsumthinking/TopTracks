import MusicKit
import Model
import Foundation
import Constants

@MainActor
class BackgroundCache {
  private(set) var currentSong: TopTracksSong?
  private(set) var currentStation: TopTracksStation?
  private(set) var currentTime: TimeInterval
  
  private var previewPlayerBeginsTask: Task<Void, Never>?
  @MainActor
  private var previewPlayerHasNotStarted = true
  
  
  
  init(currentSong: TopTracksSong?,
       currentStation: TopTracksStation?,
       currentTime: TimeInterval = 0) {
    self.currentSong = currentSong
    self.currentStation = currentStation
    self.currentTime = currentTime
    
    listenForPreviewPlayerBeginning()
  }
  
  deinit {
    previewPlayerBeginsTask?.cancel()
  }
}

extension BackgroundCache {
  private func listenForPreviewPlayerBeginning() {
    previewPlayerBeginsTask = Task {
      for await _ in NotificationCenter.default.notifications(named: Constants.previewPlayerBeginsNotification) {
        guard previewPlayerHasNotStarted else { return }
        self.previewPlayerHasNotStarted = false
        currentSong =  CurrentSong.shared.nowPlaying
        currentTime = ApplicationMusicPlayer.shared.playbackTime
        ApplicationMusicPlayer.shared.pause()
      }
    }
  }
}
