import SwiftUI

struct StationBuildCancellation {
  @State private var showCancel = false
  @EnvironmentObject private var stationConstructionStatus: StationContructionStatus
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
      .alert("Stop creating this new station?",
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
    stationConstructionStatus.isCreatingNew = false
  }
}

