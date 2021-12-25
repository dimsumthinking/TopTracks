import SwiftUI

struct StationBuildCancellation {
  @State private var showCancel = false
  @EnvironmentObject private var buildingStatus: BuildingStatus
}

extension StationBuildCancellation: ViewModifier {
  func body(content: Content) -> some View {
    content
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Stop Building",
                 role:.destructive,
                 action: showCancelAlert)
        }
      }
      .alert("Stop building this station?",
             isPresented: $showCancel){
        Button("No, keep building",
               role: .cancel,
               action: hideCancelAlert)
        Button("Yes, delete this station",
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
    AppleMusicPlaylistSongPreviewView.audioPlayer = nil
    buildingStatus.isBuilding = false
  }
}

