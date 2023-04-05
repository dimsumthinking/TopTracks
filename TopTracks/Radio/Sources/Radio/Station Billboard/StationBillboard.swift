import SwiftUI
import Model
import MusicKit
import Constants
import ApplicationState
import StationUpdaters

public struct StationBillboard {
  let station: TopTracksStation
  let currentStation: TopTracksStation?
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
      .swipeActions(edge: .leading, allowsFullSwipe: false) {
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
        print("Getting set to play", station.name)
        Task {
          do {
            try await UpdateRetriever.fetchUpdates(for: station)
            try await CurrentQueue.shared.playStation(station)
          } catch {
            print("Couldn't play station")
            CurrentQueue.shared.stopPlayingStation()
          }
        }
      }
      .animation(.default, value: currentStation)
    }
  }
}

extension StationBillboard {
  private var isNotEditing: Bool {
    editMode?.wrappedValue.isEditing != true
  }
  
  private var isCurrentStation: Bool {
    return station == currentStation
  }
  
  private var isNotCurrentStation: Bool {
    !isCurrentStation
  }
}



