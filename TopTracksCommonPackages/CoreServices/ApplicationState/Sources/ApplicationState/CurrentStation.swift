import Model
import Observation


@MainActor
@Observable
public class CurrentStation {
  public static let shared = CurrentStation()
  public internal(set) var nowPlaying: TopTracksStation?
  private let stationUpdater = CurrentStationUpdater()
}

extension CurrentStation {
  public func setStation(to station: TopTracksStation) throws {
    let persistentModelID = station.persistentModelID
    nowPlaying = station
    stationUpdater.markPlayed(stationWithID: persistentModelID)
    
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

