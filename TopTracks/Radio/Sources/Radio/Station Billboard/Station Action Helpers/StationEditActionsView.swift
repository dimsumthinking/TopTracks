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
      if !station.isChart {
        Button("Auto-Rotate Playlist") {
          do {
            try station.addAndRotate()
          }
          catch { RadioLogger.stationMusicRotator.info("Couldn't add and rotate the music for \(station.stationName)")
          }
        }
        Button ("View/Manage Playlist") {
          CurrentActivity.shared.beginStationSongList(for: station)
        }
      }
      Button("Delete Station",
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
    } catch {
      RadioLogger.stationDelete.info("Could not delete \(station.name)")
    }
    
  }
}

