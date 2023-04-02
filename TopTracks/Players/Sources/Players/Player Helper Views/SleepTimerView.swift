import SwiftUI
import MusicKit
import ApplicationState

struct SleepTimerView {
  private let times = [5, 15, 30, 60]
  @State private var endTime: Date?
  @State private var sleepsAfterSong = false
  @State private var sleepTimerIsSet = false
}

extension SleepTimerView: View {
  var body: some View {
    Menu {
      if let endTime {//} = CurrentQueue.shared.endTime {
        Text("Sleep timer set:")
        Text(endTime, style: .relative)
      }
      if sleepsAfterSong { //CurrentQueue.shared.sleepsAfterSong {
        Text("After song ends")
      }
      Menu {
        ForEach(times, id: \.self) { time in
          Button {
            sleep(after: time)
          } label: {
           Text("\(time) minutes")
          }
        }
      } label: {
        Text("Sleep in...")
      }
      Menu {
        ForEach(times, id: \.self) { time in
          Button {
            sleep(after: time,
            atEndOfSong: true)
          } label: {
           Text("\(time) minutes completes")
          }
        }
        
      } label: {
        Text("After song in...")
        
      }
      if sleepTimerIsSet {
        Button(role: .destructive) {
          cancelTimer()
        } label: {
          Text("Cancel timer")
        }
      }
    } label: {
      Image(systemName: "powersleep")
    }
    .onAppear {
      refreshSleepData()
    }
  }
}

extension SleepTimerView {
  private func sleep(after minutes: Int,
                     atEndOfSong: Bool = false) {
    CurrentQueue.shared.sleepAfter(timeInterval: Double(minutes) * 60,
                                   finishSong: atEndOfSong)
    refreshSleepData()
  }
  
  private func cancelTimer() {
    CurrentQueue.shared.cancelTimer()
    refreshSleepData()
  }
  
  private func refreshSleepData() {
    self.endTime = CurrentQueue.shared.endTime
    self.sleepsAfterSong = CurrentQueue.shared.sleepsAfterSong
    self.sleepTimerIsSet = CurrentQueue.shared.sleepTimerIsSet
  }
}
