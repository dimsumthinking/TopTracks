import CarPlay

@MainActor
class CarRadioRecents {
  let grid: CPGridTemplate
  
  init() {
    grid = CPGridTemplate(title: "Recents", gridButtons: [])
  }
}
