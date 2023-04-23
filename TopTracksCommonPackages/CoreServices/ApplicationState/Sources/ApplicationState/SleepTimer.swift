import Foundation
import MusicKit

class SleepTimer {
  let afterSong: Bool
  let timeInterval: TimeInterval
  let endTime: Date
  private var sleepTimerTask: Task<Void, Error>?
  
  
  init(for timeInterval: TimeInterval,
       finishSong afterSong: Bool = false) {
    self.timeInterval = timeInterval
    self.afterSong = afterSong
    self.endTime = Date().addingTimeInterval(timeInterval)
  }
}

extension SleepTimer {
  func sleep() async {
    #if !os(macOS)
    await withCheckedContinuation { continuation in
      sleepTimerTask?.cancel()
      sleepTimerTask = Task {
        try? await Task.sleep(for: .seconds(timeInterval))
        try Task.checkCancellation()
        if let duration = CurrentSong.shared.song?.duration,
           afterSong {
          try? await Task.sleep(for: .seconds(duration - ApplicationMusicPlayer.shared.playbackTime - 1))
        }
        ApplicationMusicPlayer.shared.pause()
        continuation.resume(returning: ())
      }
    }
    #endif
  }
}

