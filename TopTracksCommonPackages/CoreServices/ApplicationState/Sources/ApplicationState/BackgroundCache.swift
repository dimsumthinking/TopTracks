import MusicKit
import Model
import Foundation
import Constants

class BackgroundCache {
  private(set) var currentSong: Song?
  private(set) var currentStation: TopTracksStation?
  private(set) var currentTime: TimeInterval
  
  private var previewPlayerBeginsTask: Task<Void, Never>?

  private var previewPlayerHasNotStarted = true
  
  
  
  init(currentSong: Song?,
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
        previewPlayerHasNotStarted = false
        currentSong = CurrentSong.shared.song
        currentTime = ApplicationMusicPlayer.shared.playbackTime
        ApplicationMusicPlayer.shared.pause()
      }
    }
  }
}
