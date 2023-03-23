import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import StationUpdaters

public struct StationListView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @StateObject private var stationLister = StationLister()
  @EnvironmentObject private var applicationState: ApplicationState
  public init() {}
}

extension StationListView: View {
  public var body: some View {
    List {
      ForEach(stationLister.stations) {station in
        StationBillboard(station: station)
          .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
          .swipeActions {
            Button(role: .destructive) {
              stationLister.deleteStation(station)
            }  label: {
              Image(systemName: "trash.fill")
            }
          }
          .swipeActions(edge: .leading) {
            Button {
              ApplicationState.shared.beginStationgSongList(for: station)
            } label: {
              Image(systemName: "music.note.list")
            }
            .tint(.orange)
            if !station.isChart && station.availableSongs.count > 24 {
              Button {
                let rotator = RotateExistingMusic(in: station)
                rotator.rotate()
              } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle")
              }
              .tint(.cyan)
            }
            if let added = station.stack(for: .added),
               (!station.isChart && added.songs.count > 4) {
              Button {
                let adder = AddAndRotateMusic(in: station)
                adder.add()
              } label: {
                Image(systemName: "goforward.plus")
              }
              .tint(.mint)
            }
          }
      }
      if stationLister.stations.isEmpty {
        HStack {
          Text("Tap")
          Image(systemName: "plus")
          Text("to create a station")
          Image(systemName: "arrow.up.right")
        }
        .font(.headline)
        .foregroundColor(.yellow)
      }
    }
    .padding(.bottom, Constants.miniPlayerArtworkImageSize/2)
    .onAppear {
      stationLister.updateStationList()
    }
    .animation(.default, value: stationLister.stations)
    .listStyle(.plain)
  }
}



