import SwiftUI
import MusicKit

struct StationBillboardView {
  let station: TopTracksStation
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @State private var stationIsCurrentlyPlaying = false
  let isLocked: Bool
  @State var displayLockedAlert = false
}

extension StationBillboardView: View {
  var body: some View {
    ZStack {
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
      if isLocked {
     Rectangle()
        .foregroundColor(Color(UIColor.systemBackground).opacity(0.7))
        .onTapGesture(perform: showAlert)
      Image(systemName: "lock.fill")
        .font(.largeTitle)
        .foregroundColor(.primary.opacity(0.9))
      }
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
}

extension StationBillboardView {
  private var isCurrentStation: Bool {
    guard let currentlyPlayingStation = currentlyPlaying.station else {return false}
    return (currentlyPlayingStation == station)
  }
}



