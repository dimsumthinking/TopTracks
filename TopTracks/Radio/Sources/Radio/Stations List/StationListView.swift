import SwiftUI
import Model
import ApplicationState
import SwiftData
import Constants
import MusicKit

struct StationListView: View {
  @Query(sort: \TopTracksStation.buttonPosition, order: .forward, animation: .bouncy) var stations: [TopTracksStation]
  @Environment(\.modelContext) private var modelContext
  @State private var searchingForRandomStation: Bool = false
}

extension StationListView {
  var body: some View {
    List {
      ForEach(stations) {station in
        StationBillboard(station: station)
        //          .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
          .listRowInsets(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
          .swipeActions(allowsFullSwipe: true) {
            Button(role: .destructive) {
              deleteStation(station)
            }  label: {
              Image(systemName: "trash.fill")
            }
            if let playlistID = station.playlistID,
               let url = URL(string: "toptracks://playlist?id=\(playlistID)") {
              ShareLink("",
                        item: url,
                        subject: Text("Top Tracks Station \(station.playlist?.name ?? station.stationName)"),
                        message: Text("\n Add \(station.playlist?.name ?? station.stationName) to your TopTracks Stations"),
                        preview: SharePreview("\(station.playlist?.name ?? station.stationName)",
                                              image: Image("AppIcon")))
              .tint(.blue)
            }
          }
        
      }
      .onMove { indexSet, offset in
        if let fromLocation = indexSet.first {
          moveStation(from: fromLocation,
                      offset: offset)
        }
      }
      
      if stations.isEmpty {
        CloudActivityView()
      }
      if CurrentStation.shared.nowPlaying != nil {
        Rectangle()
          .frame(height: Constants.miniPlayerArtworkImageSize * 3 / 2)
          .foregroundColor(.clear)
      }
    }
    //    .listRowSeparatorTint(.clear)
    .listStyle(.plain)
    .animation(.default, value: stations)
    
    .toolbar {
      if stations.count > 2 {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            Task {
              searchingForRandomStation = true
              try await CurrentQueue.shared.playRandomStation(stations)
              try await Task.sleep(for: .seconds(2))
              searchingForRandomStation = false
            }
          } label: {
            Image(systemName: "dice")
          }
          .disabled(searchingForRandomStation)
        }
      }
    }
  }
}

extension StationListView {
  func deleteStation(_ station: TopTracksStation) {
    CurrentQueue.shared.stopPlayingDeletedStation(station)
    modelContext.delete(station)
    do {
      try modelContext.save()
      for (index, station) in stations.enumerated() {
        station.buttonNumber = index
      }
      try modelContext.save()
    } catch {
      RadioLogger.stationDelete.info("Could not delete \(station.name)")
    }
  }
}

extension StationListView {
  func moveStation(from currentPosition: Int,
                   offset: Int) {
    if currentPosition < offset {
      stations[currentPosition].buttonNumber = offset - 1 // was just offset
      for (index, station) in stations.enumerated() where index > currentPosition && index < offset {
        station.buttonPosition -= 1
      }
    } else {
      stations[currentPosition].buttonNumber = offset
      for (index, station) in stations.enumerated() where index >= offset && index < currentPosition {
        station.buttonPosition += 1
      }
    }
    do {
      try modelContext.save()
    } catch {
      RadioLogger.stationOrder.info("Couldn't move station by dragging")
    }
  }
}



