import SwiftUI

struct StationBuildCancellation {
  @State private var showCancel = false
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension StationBuildCancellation: ViewModifier {
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

extension StationBuildCancellation {
  private func showCancelAlert() {
    showCancel = true
  }
  private func hideCancelAlert() {
    showCancel = false
  }
}

extension StationBuildCancellation {
  private func stopBuilding() {
    musicTestPreviewPlayer.audioPlayer = nil
    topTracksStatus.isCreatingNew = false
  }
}

