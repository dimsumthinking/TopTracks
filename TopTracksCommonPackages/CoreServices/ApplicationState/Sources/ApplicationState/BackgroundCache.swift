import MusicKit
import Model
import Foundation
import Constants

class BackgroundCache {
  private(set) var currentSong: Song?
  private(set) var currentStation: TopTracksStation?
  private(set) var currentTime: TimeInterval
  
  private var previewPlayerTask: Task<Void, Never>?
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
    previewPlayerTask?.cancel()
  }
}

extension BackgroundCache {
  private func listenForPreviewPlayerBeginning() {
    previewPlayerTask = Task {
      for await _ in NotificationCenter.default.notifications(named: Constants.previewPlayerBeginsNotification) {
        guard previewPlayerHasNotStarted else { return }
        previewPlayerHasNotStarted = false
        currentSong = CurrentSong.shared.song
//        #if !os(macOS)
        currentTime = ApplicationMusicPlayer.shared.playbackTime
//        #endif
      }
    }
  }
}
