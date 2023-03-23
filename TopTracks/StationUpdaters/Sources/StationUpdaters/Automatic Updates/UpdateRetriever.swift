import Model
import MusicKit

public class UpdateRetriever {
  public init() {}
}

extension UpdateRetriever {
  public static func fetchUpdates(for station: TopTracksStation ) async throws {
    if station.isChart {
      let chartUpdater = ChartUpdater()
      try await chartUpdater.update(station)
    }
    else {
      let playlistUpdater = PlaylistUpdater()
      try await playlistUpdater.update(station)
    }
  }
  
}
