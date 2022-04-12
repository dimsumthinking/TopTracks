import SwiftUI
import MusicKit

struct StationBillboardView {
  let station: TopTracksStation
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @State private var stationIsCurrentlyPlaying = false
}

extension StationBillboardView: View {
  var body: some View {
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
    .onTapGesture {
      if currentlyPlaying.station == station {return}
      currentlyPlaying.station = station
      stationIsCurrentlyPlaying = true
      Task {
        try await stationSongPlayer.play(station)
      }
    }
    .border(isCurrentStation ? Color.cyan : Color.secondary.opacity(0.4),
            width: isCurrentStation ? 3 : 1)

  }
}

extension StationBillboardView {
  private var isCurrentStation: Bool {
    guard let currentlyPlayingStation = currentlyPlaying.station else {return false}
    return (currentlyPlayingStation == station)
  }
}



