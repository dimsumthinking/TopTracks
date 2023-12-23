import SwiftUI
import WatchKit
import Model
import SwiftData


struct MainView {
  @ObservedObject private(set) var watchConnector: WatchConnector
  @Query private var stations: [TopTracksStation]
  @State private var cantPlayRandomStation = false
}

extension MainView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("Now Playing") {
          NowPlayingView()
        }
        if !stations.isEmpty {
          NavigationLink("Station List") {
            WatchStationListView(watchConnector: watchConnector)
          }
        }
        Button("Play Random Station") {
          Task {
            cantPlayRandomStation = true
            watchConnector.requestRandomStation()
            try await Task.sleep(for: .seconds(5))
            cantPlayRandomStation = false
          }
        }
        .disabled(cantPlayRandomStation)
      }
      .navigationTitle("Top Tracks")
    }
  }
}


#Preview {
  MainView(watchConnector: WatchConnector(action: {_ in}))
}
