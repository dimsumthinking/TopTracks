import CarPlay

@MainActor
class CarRadioStations {
  let list: CPListTemplate
//  var stations = SimpleStationLister().stations
  
  init() {
    list = CPListTemplate(title: "Stations",
                          sections: [])
  }
}
