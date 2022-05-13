import SwiftUI

struct MusicTestCancellation {
  @State private var showCancel = false
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  let finish: () -> Void
}

extension MusicTestCancellation: ViewModifier {
  func body(content: Content) -> some View {
    content
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Dismiss",
                 role:.destructive,
                 action: showCancelAlert)
        }
      }
      .alert("Stop creating a new station?",
             isPresented: $showCancel){
        Button("Stop and discard work",
               role: .destructive,
               action: stopBuilding)
      }
  }
}

extension MusicTestCancellation {
  private func showCancelAlert() {
    showCancel = true
  }
  private func hideCancelAlert() {
    showCancel = false
  }
}

extension MusicTestCancellation {
  private func stopBuilding() {
    songPreviewPlayer.audioPlayer = nil
    topTracksStatus.stopCreating()
  }
  private func finishAutomatically() {
    hideCancelAlert()
    finish()
  }
}

