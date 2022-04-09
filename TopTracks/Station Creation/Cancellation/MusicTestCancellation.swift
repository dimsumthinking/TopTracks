import SwiftUI

struct MusicTestCancellation {
  @State private var showCancel = false
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
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
               role: .cancel,
               action: hideCancelAlert)
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
    topTracksStatus.isCreatingNew = false
  }
}

