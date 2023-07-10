enum MainStationsSheet {
  case settings
  case info
}

extension MainStationsSheet: Identifiable {
  var id: Self {
    self
  }
}


