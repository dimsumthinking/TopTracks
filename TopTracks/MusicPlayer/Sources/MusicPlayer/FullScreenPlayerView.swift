import SwiftUI
import MusicKit

public struct FullScreenPlayerView {
  @ObservedObject private var state = ApplicationMusicPlayer.shared.state
  public init() {}
}

extension FullScreenPlayerView: View {
  public var body: some View {
    VStack {
      Spacer()
      AlbumArtView(Player.shared.currentArtwork)
      SongScrubberView(duration: Player.shared.currentDuration)
      Spacer()
      SongInfoView(Player.shared.currentTitle,
                   Player.shared.currentArtist)
      Spacer()
      BasicPlayerControlView()
      Spacer()
    }
  }
}
