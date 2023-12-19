import SwiftUI
import WatchKit
import Model
import SwiftData


struct MainView {
  @ObservedObject private(set) var watchConnector: WatchConnector
  @Query private var stations: [TopTracksStation]
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
          watchConnector.requestRandomStation()
        }
      }
      .navigationTitle("Top Tracks")
    }
  }
}


#Preview {
  MainView(watchConnector: WatchConnector(action: {_ in}))
}
