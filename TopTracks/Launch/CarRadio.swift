import CarPlay

public class CarRadio: NSObject, CPTemplateApplicationSceneDelegate {
  var interfaceController: CPInterfaceController?
//  var carRadioStations = CarRadioStations()
 
  

  
  // CarPlay connected
  
  public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didConnect interfaceController: CPInterfaceController) {
    self.interfaceController = interfaceController
//    let listTemplate: CPListTemplate = CPListTemplate(title: "Stations", sections: [])
    let listTemplate: CPListTemplate = CPListTemplate(title: "Stations", sections: [CPListSection(items: [CPListItem(text: "Item Text", detailText: "Detail Text")])])
    Task {
      do {
        _ = try await interfaceController.setRootTemplate(listTemplate, animated: true)
      } catch {
        print("Error connecting template application scene to root")
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
