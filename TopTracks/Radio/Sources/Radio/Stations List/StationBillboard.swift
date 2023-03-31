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
      HStack(alignment: station == applicationState.currentStation ? .center : .top) {
          
          ArtworkImage(artwork,
                       width: Constants.stationListImageSize,
                       height: Constants.stationListImageSize)
          .padding(.trailing)
          VStack(alignment: .leading) {
            StationNameView(station: station,
                            isChangingName: $isChangingName)
            if station != applicationState.currentStation &&
                editMode?.wrappedValue.isEditing != true {
              Text(station.topArtists)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
                .lineLimit(3)
            }

           
          }
          if station == applicationState.currentStation {
              Spacer()
              
              Image(systemName: "antenna.radiowaves.left.and.right")
                .padding(.trailing)
                .font(.largeTitle)
                .foregroundColor(.yellow)
            }
        }
//      .moveDisabled(station.isEmpty)
//      .deleteDisabled(station.isEmpty)
      .listRowBackground(LinearGradient(colors: [Color(backgroundColor).opacity(0.9), Color(backgroundColor).opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)
        .border(station == applicationState.currentStation ? .yellow : .clear)                )
      .contentShape(Rectangle())
      .onTapGesture {
        guard editMode?.wrappedValue.isEditing != true else {
          isChangingName.toggle()
          return
        }
        guard station != applicationState.currentStation else { return }
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

