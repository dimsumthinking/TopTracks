import SwiftUI

struct InfoModifier {
  let message: String
  @State private var showInfo = false
  @State private var showCancel = false
  @EnvironmentObject private var buildingStatus: BuildingStatus
}

extension InfoModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button("Stop Building",
                 role:.destructive,
                 action: showCancelAlert)
          Button(action: showInfoAlert) {
            Image(systemName: "info.circle")
          }
        }
      }
      .alert(message, isPresented: $showInfo) {
        Button("OK",
               role: .cancel,
               action: hideInfoAlert)
        Button("Cancel",
               role:.cancel,
               action: showCancelAlert)
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

extension InfoModifier {
  private func showInfoAlert() {
    showInfo = true
  }
  private func hideInfoAlert() {
    showInfo = false
  }
}

extension InfoModifier {
  private func showCancelAlert() {
    showCancel = true
  }
  private func hideCancelAlert() {
    showCancel = false
  }
}

extension InfoModifier {
  private func stopBuilding() {
    buildingStatus.isBuilding = false
  }
}

