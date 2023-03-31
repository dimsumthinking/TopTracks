import SwiftUI
import Model
import MusicKit
import Constants
import ApplicationState
import StationUpdaters

public struct StationBillboard {
  let station: TopTracksStation
  @EnvironmentObject private var applicationState: ApplicationState
  @State private var isChangingName = false
  @State private var stationName = ""
  @Environment(\.editMode) private var editMode
}

extension StationBillboard: View {
  public var body: some View {
    if let artwork = station.artwork,
       let backgroundColor = artwork.backgroundColor {
      HStack(alignment: isCurrentStation ? .center : .top) {
        BillboardImage(artwork: artwork)
        VStack(alignment: .leading) {
          StationNameView(station: station,
                          isChangingName: $isChangingName)
          if isNotCurrentStation && isNotEditing {
            StationFeatured(featured: station.topArtists)
          }
        }
        if isCurrentStation {
          CurrentStationIndicator()
        }
      }
      .listRowBackground(BillboardBackground(backgroundColor: backgroundColor,
                                             isCurrentStation: isCurrentStation))
      .swipeActions(edge: .leading) {
        ShowStacksButton(station: station)
        if !station.isChart && station.availableSongs.count > 24 {
          RotateMusicButton(station: station)
        }
        if let added = station.stack(for: .added),
           (!station.isChart && added.songs.count > 4) {
          AddAndRotateMusicButton(station: station)
        }
      }
      .contentShape(Rectangle())
      .onTapGesture {
        guard isNotEditing  else {
          isChangingName.toggle()
          return
        }
        guard isNotCurrentStation else { return }
        Task {
          do {
            try await UpdateRetriever.fetchUpdates(for: station)
            try await applicationState.playStation(station)
          } catch {
            print("Couldn't play station")
            applicationState.noStationSelected()
          }
        }
      }
      .animation(.default, value: applicationState.currentStation)
    }
  }
}

extension StationBillboard {
  private var isNotEditing: Bool {
    editMode?.wrappedValue.isEditing != true
  }
  
  private var isCurrentStation: Bool {
    station == applicationState.currentStation
  }
  
  private var isNotCurrentStation: Bool {
    !isCurrentStation
  }
}

