import SwiftUI
import Model
import MusicKit
import Constants
import ApplicationState

public struct StationBillboard {
  let station: TopTracksStation
  @EnvironmentObject private var applicationState: ApplicationState
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
          VStack(alignment: .leading) {
            Text(station.name)
              .font(.headline)
              .padding(.bottom, 8)
            Text(station.topArtists)
              .font(.caption)
              .multilineTextAlignment(.leading)
              .foregroundColor(.secondary)
              .lineLimit(3)
          }
        }
        if station == applicationState.currentStation {
          Text("")
            .padding(.bottom)
        }
      }
      .listRowBackground(LinearGradient(colors: [Color(backgroundColor).opacity(0.9), Color(backgroundColor).opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)
                         )
      .contentShape(Rectangle())
      .onTapGesture {
        applicationState.setStation(to: station)
        Task {
          do {
            try await stationSongPlayer.play(station)
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
