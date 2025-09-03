@preconcurrency import CarPlay
import Model
import ApplicationState
import SwiftData

@MainActor
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
            .sorted { $0.lastTouched > $1.lastTouched}
        } catch {
          RadioCarLogger.fetchingStations.info("Couldn't fetch stations")
        }
    }
  }
  
  // CarPlay connected
  nonisolated
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                       didConnect interfaceController: CPInterfaceController) {
    Task {
    await setUpStations()
      await MainActor.run {
        self.interfaceController = interfaceController
        let items =  stations.map {station in
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
  }
  nonisolated
  // CarPlay disconnected
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
    Task {@MainActor in
      self.interfaceController = nil
    }
    
  }
  //  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
  //                                didDisconnect interfaceController: CPInterfaceController) {
  //    self.interfaceController = nil
  //  }
  
}
