import SwiftUI
import ApplicationState

struct SleepTimer {
  private let times = [5, 15, 30, 60]
  @State private var showingTimerOptions = false
  @State private var atEndOfSong = false
}

extension SleepTimer: View {
  var body: some View {
    HStack {
      Button {
        atEndOfSong = false
        showingTimerOptions = true
      } label: {
        Image(systemName: "bed.double")
      }
      .padding(.trailing)
      Button {
        atEndOfSong = true
        showingTimerOptions = true
      } label: {
        Image(systemName: "bed.double.fill")
      }
    }
    .alert("Sleep \(atEndOfSong ? "after song playing" : "") in",
           isPresented: $showingTimerOptions) {
      ForEach(times, id: \.self) { time in
        Button {
          sleep(after: time)
        } label: {
          Text("\(time) minutes")
        }
      }
      if let _ = ApplicationState.shared.endTime {
        Button(role: .destructive) {
          ApplicationState.shared.cancelTimer()
        } label: {
          Text("Stop sleep timer")
        }
      }
      Button(role: .cancel) {
        showingTimerOptions = false
      } label: {
        Text("Cancel")
      }
    } message: {
      if let endTime = ApplicationState.shared.endTime {
        Text("(Timer is set for: ") + Text(endTime, style: .time) + Text(")")
      }
    }
  }
}

extension SleepTimer {
  private func sleep(after minutes: Int) {
    ApplicationState.shared.sleepAfter(timeInterval: Double(minutes) * 60,
                                       andSongPlayingThen: atEndOfSong)
    showingTimerOptions = false
  }
}


