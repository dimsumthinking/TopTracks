import CarPlay

@MainActor
class CarRadioMain {
  let tabs: CPTabBarTemplate
  
  init() {
    tabs = CPTabBarTemplate(templates: [
      CarRadioRecents().grid,
      CarRadioStations().list
    ])
  }
}
