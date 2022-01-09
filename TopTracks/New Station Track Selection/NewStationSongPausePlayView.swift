import SwiftUI
import MusicKit

struct NewStationSongPausePlayView {
  let artwork: Artwork
  let isPlaying: Bool
  
  init?(using artwork: Artwork?,
        isPlaying: Bool) {
    guard let artwork = artwork else {return nil}
    self.artwork = artwork
    self.isPlaying = isPlaying
  }
}

extension NewStationSongPausePlayView: View {
  var body: some View {
    Image(systemName: isPlaying ? "stop" : "play" )
      .font(.largeTitle)
      .foregroundColor(artwork.secondaryTextColor.map(Color.init(cgColor:)) ?? .primary)
      .background(artwork.backgroundColor.map(Color.init(cgColor:)) ?? .secondary)
      .buttonStyle(.bordered)
  }
}


