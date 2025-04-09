import SwiftUI
import SwiftData
import Model
import ApplicationState


public struct StationEditActionsView: View {
  let station: TopTracksStation
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
}

extension StationEditActionsView {
  public var body: some View {
    VStack {
      Button ("Manage Playlist") {
        
      }
      Button("Delete",
             role: .destructive) {
        delete()
        dismiss()
      }
      Button("Cancel",
             role: .cancel) {
        dismiss()
      }
    }
  }
}

extension StationEditActionsView {
  private func delete() {
    CurrentQueue.shared.stopPlayingDeletedStation(station)
    modelContext.delete(station)
    do {
      try modelContext.save()
      //      for (index, station) in stations.enumerated() {
      //        station.buttonNumber = index
      //      }
//      try modelContext.save()
    } catch {
      RadioLogger.stationDelete.info("Could not delete \(station.name)")
    }
    
  }
}

