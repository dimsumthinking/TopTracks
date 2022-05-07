import SwiftUI
import MusicKit

struct StationBillboardView {
  let station: TopTracksStation
  let deleteAction: (TopTracksStation, CurrentlyPlaying) -> Void
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @State private var stationIsCurrentlyPlaying = false
  let isLocked: Bool
  @State var displayLockedAlert = false
  @State var isLoading = false
  @State var isShowingPreview = false
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension StationBillboardView: View {
  var body: some View {
    ZStack {
      VStack {
        HStack {
          StationIconView(station: station)
            .frame(width: stationListCellWidth, height: stationListCellWidth, alignment: .center)
            .padding()
          VStack (alignment: .leading){
            Text(station.stationName)
              .multilineTextAlignment(.leading)
              .font(.title3)
            if let lastUpdated = station.playlistInfo?.lastUpdated { //.station && (station.chartNeedsRefreshing || (station.playlistCanBeUpdated)) {
              Group {
                Text("Updated ") + Text(lastUpdated, style: .date)
              }
              .font(.caption)
              .foregroundColor(.secondary)
            }
          }
          Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {playStation()}
        .swipeActions(edge: .leading,
                      allowsFullSwipe: false) {
          if !isLocked && station.stationType != .station {
            Button(action: {isShowingPreview = true}){
              Image(systemName: "magnifyingglass")
            }
            .tint(.indigo)
            if station.stationType == .chart {
              Button(action: updateChartStation) {
                Image(systemName: "arrow.triangle.2.circlepath")
              }
              .disabled(!station.chartNeedsRefreshing || topTracksStatus.isNotConnected)
              .tint(.orange)
            } else if station.stationType == .playlist {
              Button(action: updatePlaylistStation) {
                Image(systemName: "arrow.triangle.2.circlepath")
              }
              .disabled(!station.playlistCanBeUpdated ||  topTracksStatus.isNotConnected)
              .tint(.orange)
            }
          }
        }
        .swipeActions {
          Button(role: .destructive,
                 action: {deleteAction(station, currentlyPlaying)}){
            Image(systemName: "trash.fill")
          }
        }
      }
      .border(isCurrentStation ? Color.cyan : Color.secondary.opacity(0.4),
              width: isCurrentStation ? 3 : 1)
      if isLocked {
     Rectangle()
        .foregroundColor(Color(UIColor.systemBackground).opacity(0.7))
        .onTapGesture(perform: showAlert)
      Image(systemName: "lock.fill")
        .font(.largeTitle)
        .foregroundColor(.primary.opacity(0.9))
      }
      if isLoading {
        Rectangle()
           .foregroundColor(Color(UIColor.systemBackground).opacity(0.7))
        ProgressView()
          .progressViewStyle(.circular)
          .font(.largeTitle)
          .foregroundColor(.yellow)
      }
    }
    .sheet(isPresented: $isShowingPreview) {
      ExistingStationPreview(station: station,
                             isShowingPreview: $isShowingPreview)
    }
    .alert("You need to re-subscribe \nto unlock more than\n three stations. \n\nTesters - toggle the subscribe switch in settings",
           isPresented: $displayLockedAlert){
      Button("OK", action: {displayLockedAlert = false})
    }
  }
}

extension StationBillboardView {
  private func showAlert() {
    displayLockedAlert = true
  }
  
  private func playStation() {
    if currentlyPlaying.station == station {return}
    currentlyPlaying.station = station
    stationIsCurrentlyPlaying = true
    Task {
      if station.stationType == .chart && station.chartNeedsRefreshing  {
        updateChartStation()
      }
      try await stationSongPlayer.play(station)
      if station.stationType == .playlist && station.playlistNeedsRefreshing {
        await station.refreshPlaylist()
      }
    }
  }

  
  private func updateChartStation() {
    Task {
      isLoading = true
      await station.updateChart()
      isLoading = false
    }
  }
  private func updatePlaylistStation() {
    //TODO: Update update flow
//    topTracksStatus.startUpdating(station)
    station.updatePlaylistStation()
  }
}


extension StationBillboardView {
  private var isCurrentStation: Bool {
    guard let currentlyPlayingStation = currentlyPlaying.station else {return false}
    return (currentlyPlayingStation == station)
  }
}



