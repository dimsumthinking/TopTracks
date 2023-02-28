
import SwiftUI
import MusicKit
import PlaylistSearch

struct MainView: View {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  
    var body: some View {
//      ChartTypeSelectionView()
      PlaylistSearchDirectoryView()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

