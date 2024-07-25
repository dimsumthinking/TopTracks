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
    let timeInterval = self.timeInterval
    let afterSong = self.afterSong
    await withCheckedContinuation { continuation in
      sleepTimerTask?.cancel()
      sleepTimerTask = Task {
        try? await Task.sleep(for: .seconds(timeInterval))
        try Task.checkCancellation()
        async let duration =   CurrentSong.shared.duration
        if afterSong {
          try? await Task.sleep(for: .seconds(duration - ApplicationMusicPlayer.shared.playbackTime - 1))
        }
      }
      ApplicationMusicPlayer.shared.pause()
      continuation.resume(returning: ())
    }
  }
}


