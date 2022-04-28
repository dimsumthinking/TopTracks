import SwiftUI
import MusicKit

struct StationBillboardView {
  let station: TopTracksStation
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @State private var stationIsCurrentlyPlaying = false
  let isLocked: Bool
  @State var displayLockedAlert = false
  @State var isLoading = false
  @Environment(\.editMode) private var editMode
  @AppStorage("hasAppSubscription") private var hasAppSubscription = false
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
          Text(station.stationName)
            .multilineTextAlignment(.leading)
            .font(.title3)
            .padding(.vertical, 20)
          Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {playStation()}
        if let mode = editMode,
           mode.wrappedValue.isEditing && !isLocked && station.stationType != .station {
          HStack {
            Button("Preview",
                   action: {isShowingPreview = true})
            .padding()
            Spacer()
            if station.stationType == .chart {
              Button("Update",
                     action: updateChartStation)
              .disabled(!station.chartNeedsUpdating || topTracksStatus.isNotConnected)
              .padding()
            } else if station.stationType == .playlist {
              Button("Update",
                     action: updatePlaylistStation)
              .disabled(!station.playlistCanBeUpdated ||  topTracksStatus.isNotConnected)
              .padding()
            }
          }
          .buttonStyle(.bordered)
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
      if station.stationType == .chart && station.chartNeedsUpdating  {
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
  
  }
}


extension StationBillboardView {
  private var isCurrentStation: Bool {
    guard let currentlyPlayingStation = currentlyPlaying.station else {return false}
    return (currentlyPlayingStation == station)
  }
}



