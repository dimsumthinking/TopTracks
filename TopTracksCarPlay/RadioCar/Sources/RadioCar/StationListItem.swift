import CarPlay
import Model
import ApplicationState

@MainActor
class StationListItem  {
  let item: CPListItem
  
  init(station: TopTracksStation,
       interfaceController: CPInterfaceController) {
    item = CPListItem(text: station.stationName,
                      detailText: station.playlist?.shortDescription)
    item.handler = {item, completion in
      interfaceController.pushTemplate(CPNowPlayingTemplate.shared,
                                       animated: true,
                                       completion: nil)
      
      if let currentStation = CurrentStation.shared.nowPlaying {
        if currentStation != station {
          self.play(station: station)
        }
      } else {
        self.play(station: station)
      }      
      completion()
    }
  }
  
  fileprivate func play(station: TopTracksStation) {
    Task {
      do {
        try await CurrentQueue.shared.playStation(station)
      } catch {
        RadioCarLogger.playingStation.info("Can't play station \(station.name)")
        CurrentQueue.shared.stopPlayingStation()
      }
    }
  }
}


//fileprivate func play(station: TopTracksStation) {
//  Task {
//    do {
//      try await CurrentQueue.shared.playStation(station)
//    } catch {
//      RadioCarLogger.playingStation.info("Can't play station \(station.name)")
//      CurrentQueue.shared.stopPlayingStation()
//    }
//  }
//}
