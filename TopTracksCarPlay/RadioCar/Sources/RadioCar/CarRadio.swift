import CarPlay
import Model
import ApplicationState
import SwiftData

public class CarRadio: NSObject, CPTemplateApplicationSceneDelegate {
  var interfaceController: CPInterfaceController?
  private var currentStation: TopTracksStation? = CurrentStation.shared.nowPlaying
  private var context = CommonContainer.shared.container.mainContext
  
  private var stations = [TopTracksStation]()
  
  
  private func setUpStations() async {
      await MainActor.run {
        do {
          stations = try CommonContainer.shared.container.mainContext
            .fetch(FetchDescriptor<TopTracksStation>())
            .sorted { $0.buttonPosition < $1.buttonPosition}
        } catch {
          RadioCarLogger.fetchingStations.info("Couldn't fetch stations")
        }
    }
  }
  
  // CarPlay connected
  
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                       didConnect interfaceController: CPInterfaceController) {
    Task {
    await setUpStations()
    self.interfaceController = interfaceController
    let items = stations.map {station in
      StationListItem(station: station,
                                 interfaceController: interfaceController).item
    }
    let list = CPListTemplate(title: "Stations",
                              sections: [CPListSection(items: items)])
    
    self.interfaceController?.setRootTemplate(list, animated: true, completion: nil)
      if let _ = CurrentStation.shared.nowPlaying {
        interfaceController.pushTemplate(CPNowPlayingTemplate.shared, animated: true, completion: nil)
      }
    }
  }
  
  // CarPlay disconnected
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
    self.interfaceController = nil
    
  }
  //  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
  //                                didDisconnect interfaceController: CPInterfaceController) {
  //    self.interfaceController = nil
  //  }
  
}
