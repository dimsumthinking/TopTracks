
import SwiftUI
import MusicKit
import MusicPlayer

struct MainView: View {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  
    var body: some View {
      FullScreenPlayerView()
        .onAppear {
          Task {
            try  await Player.shared.fetch()
          }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

