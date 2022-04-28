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
          Button("Cancel",
                 role:.destructive,
                 action: showCancelAlert)
        }
      }
      .alert("Stop creating a new station?",
             isPresented: $showCancel){
        Button("No, keep going",
               action: hideCancelAlert)
        Button("Finish automatically",
               action: finishAutomatically )
        Button("Yes",
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
    topTracksStatus.endCreating()
  }
  private func finishAutomatically() {
    hideCancelAlert()
    finish()
  }
}

