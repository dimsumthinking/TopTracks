import SwiftUI
import MusicKit

public struct MiniPlayerView {
  @ObservedObject private var state = ApplicationMusicPlayer.shared.state
   public init() {
  }
}

extension MiniPlayerView: View {
  public var body: some View {
    HStack {
      AlbumArtView(Player.shared.currentArtwork)
        .frame(width: 100)
        .padding(.vertical)
      VStack {
        SongInfoView(Player.shared.currentTitle,
                     Player.shared.currentArtist)
        .padding(.bottom)
        BasicPlayerControlView()
      }
    }
  }
}
