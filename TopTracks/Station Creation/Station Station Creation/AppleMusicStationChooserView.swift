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
    guard !filterText.isEmpty else {return appleMusicStationSearch.stationCategories}
    return appleMusicStationSearch.stationCategories
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
    guard !filterText.isEmpty else {
      return appleMusicStationSearch
      .stations(in: category)
      .sorted {$0.name < $1.name}
    }
    return appleMusicStationSearch.stations(in: category)
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
