import SwiftData

let background = BackgroundProvider()

 struct BackgroundProvider {
  var context: ModelContext {
    ModelContext(CommonContainer.shared.container)
  }
   
   func station(from existingStation: TopTracksStation) throws -> (TopTracksStation, ModelContext) {
     let newBackgroundContext = context
     guard let station = newBackgroundContext.model(for: existingStation.persistentModelID) as? TopTracksStation else {
       throw TopTracksDataError.couldNotCreateStationOnBackgroundContext
     }
     return (station, newBackgroundContext)
   }
}


