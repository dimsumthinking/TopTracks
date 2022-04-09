import SwiftUI
import MusicKit

struct MainStationPlayerView {
  @State private var isShowingPlayer = false
}

extension MainStationPlayerView: View {
  var body: some View {
    VStack {
      StationsView()
      Text("This will be small player view")
        .contentShape(Rectangle())
        .onTapGesture {
          isShowingPlayer = true
        }
    }
    .sheet(isPresented: $isShowingPlayer) {
      Image(systemName: "arrow.right")
        .resizable()
        .scaledToFit()
    }
  }
}


struct MainStationPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    MainStationPlayerView()
  }
}
