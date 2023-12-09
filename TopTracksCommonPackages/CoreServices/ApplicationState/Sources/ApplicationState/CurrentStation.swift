import Model
import Foundation
import Observation

@Observable
public class CurrentStation {
  public static let shared = CurrentStation()
  public internal(set) var nowPlaying: TopTracksStation?
}

extension CurrentStation {
  
  public func setStation(to station: TopTracksStation) throws {
    try station.startPlaying()
    nowPlaying = station
  }
}

extension CurrentStation {
  public func noStationSelected() {
   nowPlaying = nil
    CurrentSong.shared.noSongSelected()
  }
  public var canShowRating: Bool {
    guard let nowPlaying else { return false }
    return !nowPlaying.isChart
  }
}

