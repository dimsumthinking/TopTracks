import SwiftUI
import MusicKit

struct AppleMusicStationChooserView {
  @StateObject private var appleMusicStationSearch = AppleMusicStationSearch()
  @State private var filterText = ""
}

extension AppleMusicStationChooserView: View {
  var body: some View {
    List {
      ForEach(filteredCategories) {category in
        Section(category.name) {
          ForEach(filteredStations(in: category)) {station in
            NavigationLink {
              StationCreationForAppleMusicStation(station: station)
            } label : {
              AppleMusicStationDetailView(station: station)
                .contentShape(Rectangle())
            }
          }
        }
      }
    }
    .searchable(text: $filterText)
    .navigationTitle("Apple Stations")
    .navigationBarTitleDisplayMode(.inline)
    .modifier(NewStationCancellation())
    .onAppear() {
      Task {
        await appleMusicStationSearch.stationSearch()
      }
    }
  }
}

extension AppleMusicStationChooserView {
  private var filteredCategories: [AppleMusicStationCategory] {
    let categories = appleMusicStationSearch.stationCategories
    guard !filterText.isEmpty else {return categories}
    return categories
      .filter {category in
        (category.name.lowercased()
          .contains(filterText.lowercased()))
        || (appleMusicStationSearch
          .stations(in: category)
          .map(\.name)
          .reduce("", +).lowercased()
          .contains(filterText.lowercased()))
      }
  }
  
  private func filteredStations(in category: AppleMusicStationCategory) -> [Station] {
    let stations = Set(appleMusicStationSearch.stations(in: category))
    guard !filterText.isEmpty else {
      return stations.sorted {$0.name < $1.name}
    }
    return stations
      .filter {station in
        (category.name.lowercased().contains(filterText.lowercased()))
        || station.name.lowercased().contains(filterText.lowercased())
      }
      .sorted {$0.name < $1.name}
  }
}

struct AppleMusicStationChooserView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicStationChooserView()
  }
}
