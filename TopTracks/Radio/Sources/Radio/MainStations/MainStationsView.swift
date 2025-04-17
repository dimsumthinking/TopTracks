import SwiftUI


public struct MainStationsView: View {
  @State private var isShowingSettings = false
  @Environment(\.colorScheme) private var colorScheme
  public init() {}
}

extension MainStationsView {
  public var body: some View {
    NavigationStack {
        StationListView()
      .navigationTitle("Stations")
      #if !os(macOS)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          AddStationButton()
        }
        ToolbarItemGroup(placement: .navigationBarLeading) {
          ShowSettingsButton(isShowingSettings: $isShowingSettings)
        }
      }
      #endif
      .sheet(isPresented: $isShowingSettings) {
          SettingsView()
            .environment(\.colorScheme, colorScheme)
       
      }
    }
  }
}
