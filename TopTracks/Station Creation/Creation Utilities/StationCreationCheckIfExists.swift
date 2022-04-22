import MusicKit
import CoreData
import SwiftUI

struct StationCreationCheckIfExists {
  
}

extension StationCreationCheckIfExists {
  static func isSubscribed(to musicItemID: MusicItemID,
                           in stations: FetchedResults<TopTracksStation>,
                           chartType: TopTracksChartType) -> Bool {
    stations
      .filter {station in
        guard let stationType = station.chartType else {return false}
        return stationType == chartType
      }
      .map{$0.chartInfo?.sourceID ?? ""}
      .contains(musicItemID.rawValue)
  }
  
  static func  isSubscribed(name stationName: String,
                            in stations: FetchedResults<TopTracksStation>) -> Bool {
      stations
        .filter {station in
          station.stationType == .station
        }
        .map(\.stationName)
        .contains(stationName)
    }
}

extension StationCreationCheckIfExists {
  static func playStation(with musicItemID: MusicItemID,
                          in stations: FetchedResults<TopTracksStation>,
                          chartType: TopTracksChartType,
                          currentlyPlaying: CurrentlyPlaying) {
    let station
    = stations
      .filter {station in
        guard let stationType = station.chartType else {return false}
        return stationType == chartType
      }
      .filter {station in
        guard let chartInfo = station.chartInfo else {return false}
        return chartInfo.sourceID == musicItemID.rawValue
      }
      .first
    if let station = station {
      if currentlyPlaying.station == station {return}
      currentlyPlaying.station = station
      Task {
        try await stationSongPlayer.play(station)
      }
    }
  }
  static func playStation(with musicItemID: MusicItemID,
                          in stations: FetchedResults<TopTracksStation>,
                          stationType: TopTracksStationType,
                          currentlyPlaying: CurrentlyPlaying) {
    let station
    = stations
      .filter {station in
        stationType == station.stationType
      }
      .filter {station in
        switch stationType {
        case .station:
          guard let  appleStationInfo = station.appleStationInfo else {return false}
          return appleStationInfo.appleStationID == musicItemID.rawValue
        case .playlist:
          guard let playlistInfo = station.playlistInfo else {return false}
          return playlistInfo.playlistID == musicItemID.rawValue
        default:
          return false
        }
      }
      .first
    if let station = station {
      if currentlyPlaying.station == station {return}
      currentlyPlaying.station = station
      Task {
        try await stationSongPlayer.play(station)
      }
    }
  }
  
//  static func playStation(with musicItemID: MusicItemID,
//                          in stations: FetchedResults<TopTracksStation>,
//                          stationType: TopTracksStationType,
//                          currentlyPlaying: CurrentlyPlaying) {
//    let station
//    = stations
//      .filter {station in
//        stationType == station.stationType
//      }
//      .filter {station in
//        guard let  appleStationInfo = station.appleStationInfo else {return false}
//        return appleStationInfo.appleStationID == musicItemID.rawValue
//      }
//      .first
//    if let station = station {
//      if currentlyPlaying.station == station {return}
//      currentlyPlaying.station = station
//      Task {
//        try await stationSongPlayer.play(station)
//      }
//    }
//  }
}

