import SwiftUI

public struct MainStationsView {
  @State private var mainStationsSheet: MainStationsSheet? = nil
  @Environment(\.colorScheme) private var colorScheme
  public init() {}
}

extension MainStationsView: View {
  public var body: some View {
    NavigationStack {
        StationListView()
      .navigationTitle("Stations")
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          AddStationButton()
        }
        ToolbarItemGroup(placement: .navigationBarLeading) {
          ShowSettingsButton(mainStationsSheet: $mainStationsSheet)
          ShowInfoButton(mainStationsSheet: $mainStationsSheet)
        }
      }
      .sheet(item: $mainStationsSheet) {
        mainStationsSheet = nil
      } content: { mainStationsSheet in
        switch mainStationsSheet {
        case .settings:
          SettingsView(mainStationsSheet: $mainStationsSheet)
            .environment(\.colorScheme, colorScheme)
        case .info:
          InfoView(mainStationsSheet: $mainStationsSheet)
            .environment(\.colorScheme, colorScheme)
        }
      }
    }
  }
}
