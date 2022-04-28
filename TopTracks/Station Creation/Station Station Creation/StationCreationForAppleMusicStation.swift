import SwiftUI
import MusicKit
import CoreData

struct StationCreationForAppleMusicStation {
  let station: Station
  
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
}

extension StationCreationForAppleMusicStation: View {
  var body: some View {
    VStack {
      if let artwork = station.artwork {
        ArtworkImage(artwork,
                     width: fullArtworkImageSize,
                     height: fullArtworkImageSize)
        .padding()
      }
      Text(station.name)
        .font(.title)
        .padding()
      if isSubscribed {
        Button("Already subscribed to \n \(station.name)\n Tap to listen now",
               action: playStation)
        .buttonStyle(.borderedProminent)
        .padding(.vertical)
      } else {
        Button("Subscribe to \n \(station.name)",
               action: createStation)
        .buttonStyle(.borderedProminent)
        .padding(.vertical)
      }
    }
  }
}

extension StationCreationForAppleMusicStation {
  private var isSubscribed: Bool {
    StationCreationCheckIfExists.isSubscribed(name: station.name,
                                              in: stations)
  }
}

extension StationCreationForAppleMusicStation {
  func createStation() {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(station: station,
                             numberOfStations: stations.count,
                             context: context)
    do {
      topTracksStatus.endCreating()
      try context.save()
      print("tried to save \(station.name)")
    } catch {
      print("Not able to create a new station\n", error)
    }
  }
  
  //  private var decorationForStationName: String {
  //    let numberWithSameStart = stations.map(\.stationName)
  //      .filter{name in name.starts(with: playlist.name)}.count
  //
  //    return numberWithSameStart == 0 ? "" : (" " + (numberWithSameStart + 1).description)
  //  }
}

//struct StationCreationForCityChart_Previews: PreviewProvider {
//  static var previews: some View {
//    StationCreationForCityChart()
//  }
//}
extension StationCreationForAppleMusicStation {
  private func playStation() {
    topTracksStatus.endCreating()
    StationCreationCheckIfExists.playStation(with: station.id,
                                             in: stations,
                                             stationType: .station ,
                                             currentlyPlaying: currentlyPlaying)
  }
}
