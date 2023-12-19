import SwiftUI
import Model
import SwiftData

@main
struct TopTracksWatchApp {
  @StateObject private var watchConnector = WatchConnector(action: {_ in})
  @Environment(\.scenePhase) private var scenePhase
}

extension TopTracksWatchApp: App {
  var body: some Scene {
    WindowGroup {
      MainView(watchConnector: watchConnector)
    }
    .modelContainer(for: TopTracksStation.self)
  }
}
