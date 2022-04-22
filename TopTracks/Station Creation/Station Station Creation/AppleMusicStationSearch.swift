import MusicKit
import Foundation

class AppleMusicStationSearch: ObservableObject {
  @Published private(set) var stations: [Station] = []
  @Published private(set) var stationCategories: [AppleMusicStationCategory] = []
  private var count = 0
}

@MainActor
extension AppleMusicStationSearch {
  func stationSearch()  async {
    var request = MusicCatalogSearchRequest(term: " Station",
                                            types: [Station.self])
    request.limit = 25
    
    let response = try? await request.response()
    guard let retrievedStations = response?.stations else {return}
    add(retrievedStations.map{$0})
    Task {
//      add(appleMusicStations)
      await continueDownloading()
    }
  }
  
  private func add(_ stations: [Station]) {
    count += stations.count
    let addedStations
    = stations
      .filter{
      guard let tagline = $0.editorialNotes?.tagline else  {return false}
      return tagline.starts(with: "Apple Music")
    }
      .filter{$0.isLive == false}
    
    self.stations.append(contentsOf: addedStations)
    self.stationCategories
    = Set(self.stations.compactMap(\.editorialNotes?.tagline))
      .sorted().map(AppleMusicStationCategory.init(name: ))
  }
  
  private func continueDownloading() async {
    var tries = 1
    while tries < 8 && count < 200 {
      var request = MusicCatalogSearchRequest(term: " Station",
                                            types: [Station.self])
      request.offset = count
      request.limit = 25
      let response = try? await request.response()
      guard let additionalStations = response?.stations else {return}
      add(additionalStations.map{$0})
      tries += 1
      print("count", count, Set(stations).count)
    }
  }
}

extension AppleMusicStationSearch {
  func stations(in category: AppleMusicStationCategory) -> [Station] {
    stations.filter {$0.editorialNotes?.tagline == category.name}
  }
}
