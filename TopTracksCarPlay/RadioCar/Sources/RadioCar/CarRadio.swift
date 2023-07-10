import CarPlay
import Model
import ApplicationState
import SwiftData

public class CarRadio: NSObject, CPTemplateApplicationSceneDelegate {
  var interfaceController: CPInterfaceController?
//  private var entryPoint = CarRadioEntryPoint()
  private var currentStation: TopTracksStation?
//  private var stations = SimpleStationLister().stations
  
  
  
  // CarPlay connected
  
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                       didConnect interfaceController: CPInterfaceController) {
    fatalError("templateApplicationScene not implemented")
//    self.interfaceController = interfaceController
//    let items = stations.map {station in
//      StationListItem(station: station,
//                                 interfaceController: interfaceController).item
//    }
//    let list = CPListTemplate(title: "Stations",
//                              sections: [CPListSection(items: items)])
//    
//    self.interfaceController?.setRootTemplate(list, animated: true, completion: nil)
//    if let _ = CurrentStation.shared.topTracksStation {
//      interfaceController.pushTemplate(CPNowPlayingTemplate.shared, animated: true, completion: nil)
//    }
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
