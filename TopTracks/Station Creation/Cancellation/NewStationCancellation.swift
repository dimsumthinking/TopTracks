import SwiftUI

struct NewStationCancellation {
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension NewStationCancellation: ViewModifier {
  func body(content: Content) -> some View {
    content
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Cancel",
                 role:.destructive,
                 action: stopBuilding)
        }
      }
  }
}


extension NewStationCancellation {
  private func stopBuilding() {
    songPreviewPlayer.audioPlayer = nil
    topTracksStatus.stopCreating()
  }
}

