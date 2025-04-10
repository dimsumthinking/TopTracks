import SwiftUI
import Model
import Constants
import ApplicationState

public struct StationBillboard: View {
  let station: TopTracksStation
  @State private var currentStation = CurrentStation.shared
  @State private var isEditing = false
  @Environment(\.colorScheme) var colorScheme

}

extension StationBillboard {
  public var body: some View {
      HStack {
        BillboardImage(artwork: station.artwork)
          StationNameView(name: station.name,
                          playbackFailed: station.playbackFailed)
          Spacer()
          CurrentStationIndicator(isCurrentStation: isCurrentStation)
        }
      .background(      BillboardBackground(backgroundColor: backgroundColor,
                                            isCurrentStation: isCurrentStation))
#if !os(tvOS)
        .border(isCurrentStation ? ColorConstants.accentColor(for: colorScheme) : .clear, width: 4)
#endif
    .contentShape(Rectangle())
    .onTapGesture {
      guard isNotCurrentStation else { return }
      playStation()
    }
    .onLongPressGesture {
      isEditing = true
    }
    .alert(station.name,
           isPresented: $isEditing,
           presenting: station,
           actions: {StationEditActionsView(station: $0)})
    
    .animation(.default, value: currentStation.nowPlaying)
  }
}

extension StationBillboard {
  private var isCurrentStation: Bool {
    return station == currentStation.nowPlaying
  }
  
  private var isNotCurrentStation: Bool {
    !isCurrentStation
  }
}

extension StationBillboard {
  private var backgroundColor: CGColor {
    if let artwork = station.artwork,
       let backgroundColor = artwork.backgroundColor {
      return backgroundColor
    } else {
      return ColorConstants.color(for: station.name)
    }
  }
}

extension StationBillboard {
  private func playStation() {
    RadioLogger.playing.info("Geting set to play \(station.name)")
    Task {
      do {
        try await station.fetchUpdates()
        try await CurrentQueue.shared.playStation(station)
      } catch {
        RadioLogger.playing.info("Couldn't play \(station.name) \n \(error.localizedDescription)")
        CurrentQueue.shared.stopPlayingStation()
      }
    }
  }
}



