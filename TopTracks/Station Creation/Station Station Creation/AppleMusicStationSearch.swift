import MusicKit
import Foundation

class AppleMusicStationSearch: ObservableObject {
  @Published private(set) var stations: [Station] = []
  @Published private(set) var stationCategories: [AppleMusicStationCategory] = []
}

@MainActor
extension AppleMusicStationSearch {
  func stationSearch()  async {
    var request = MusicCatalogSearchRequest(term: " Station",
                                            types: [Station.self])
    request.limit = 25
    
    let response = try? await request.response()
    guard let stations = response?.stations else {return}
    let appleMusicStations = stations
      .filter{
      guard let tagline = $0.editorialNotes?.tagline else  {return false}
      return tagline.starts(with: "Apple Music")
    }
    Task {
      await add(appleMusicStations)
      await continueDownloading()
    }
  }
  
  private func add(_ stations: [Station]) async {
    self.stations.append(contentsOf: stations)
    self.stations = Set(self.stations)
      .sorted {
        guard let tagline1 = $0.editorialNotes?.tagline,
              let tagline2 = $1.editorialNotes?.tagline else {return true}
        return tagline1 < tagline2
      }
    self.stationCategories
    = Set(self.stations.compactMap(\.editorialNotes?.tagline))
      .sorted().map(AppleMusicStationCategory.init(name: ))
  }
  
  private func continueDownloading() async {
    var count = self.stations.count
    while count > 0 && stations.count < 200 {
      let currentCont = self.stations.count
      var request = MusicCatalogSearchRequest(term: "Station",
                                            types: [Station.self])
      request.offset = self.stations.count
      request.limit = 20
      let response = try? await request.response()
      guard let additionalStations = response?.stations else {return}
      let additionalAppleMusicStations = additionalStations
        .filter{
        guard let tagline = $0.editorialNotes?.tagline else  {return false}
        return tagline.starts(with: "Apple Music")
      }
      await add(additionalAppleMusicStations)
      count = self.stations.count - currentCont
    }
  }
}

extension AppleMusicStationSearch {
  func stations(in category: AppleMusicStationCategory) -> [Station] {
    stations.filter {$0.editorialNotes?.tagline == category.name}
  }
}
