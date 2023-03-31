import MusicKit
import Foundation


public let emptyStation = TopTracksStation(favorite: false,
                                    stationLastUpdated: Date(),
                                    playlistLastUpdated: Date(),
                                    playlistID: "-1",
                                    stationID: UUID(),
                                    stationName: "Empty",
                                    updateAvailable: false,
                                    lastTouched: Date(),
                                    allowRecommendations: false,
                                    playlistAsData: nil,
                                    stacks: Set<TopTracksStack>(),
                                                isChart: false)


extension TopTracksStation {
  fileprivate convenience init(favorite: Bool,
                   stationLastUpdated: Date,
                   playlistLastUpdated: Date,
                   playlistID: String,
                   stationID: UUID,
                   stationName: String,
                   updateAvailable: Bool,
                   lastTouched: Date,
                   allowRecommendations: Bool,
                   playlistAsData: Data?,
                   stacks: Set<TopTracksStack>,
                               isChart: Bool) {
    self.init(context: PersistenceController.newBackgroundContext)
    self.favorite = favorite
    self.stationLastUpdated = stationLastUpdated
    self.playlistLastUpdated = playlistLastUpdated
    self.playlistID = playlistID
    self.stationID = stationID
    self.stationName = stationName
    self.updateAvailable = updateAvailable
    self.lastTouched = lastTouched
    self.allowRecommendations = allowRecommendations
    self.playlistAsData = playlistAsData
    self.stacks = stacks
    self.isChart = isChart
  }
  
  public var isEmpty: Bool {
    playlistID == "-1"
  }
  
}
