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
}

extension StationBillboard: View {
  public var body: some View {
    if let artwork = station.artwork,
       let backgroundColor = artwork.backgroundColor {
      VStack {
        if station == applicationState.currentStation {
          HStack {
            Spacer()
            Image(systemName: "antenna.radiowaves.left.and.right")
              .padding(.trailing)
              .font(.largeTitle)
              .foregroundColor(.yellow)
          }
        }
        HStack(alignment: .top) {
          
          ArtworkImage(artwork,
                       width: Constants.stationListImageSize,
                       height: Constants.stationListImageSize)
          .padding(.trailing)
          VStack(alignment: .leading) {
            StationNameView(station: station,
                            isChangingName: $isChangingName)
            Text(station.topArtists)
              .font(.caption)
              .multilineTextAlignment(.leading)
              .foregroundColor(.secondary)
              .lineLimit(3)
          }
        }
        if station == applicationState.currentStation {
//          let message = (!station.isChart && station.updateAvailable) ? "New Songs Available (Swipe Right)" : ""
          HStack {
            Text(message)
              .foregroundColor(.yellow)
          }
            .padding(.bottom)
        }
      }
      .listRowBackground(LinearGradient(colors: [Color(backgroundColor).opacity(0.9), Color(backgroundColor).opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)
                         )
      .contentShape(Rectangle())
      .onTapGesture {
        guard !isChangingName else { return }
//        guard let currentStation = applicationState.currentStation,
//              currentStation.stationID != station.stationID else {return}
//        applicationState.setStation(to: station)
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
      .onLongPressGesture {
        isChangingName = true
      }
      .animation(.default, value: applicationState.currentStation)
    }
  }
}

extension StationBillboard {
  private var message: String {
    if let added = station.stack(for: .added),
       (!station.isChart && added.songs.count > 4) {
      return "New Songs Available (Swipe Right)"
    } else {
      return ""
    }
  }
}
