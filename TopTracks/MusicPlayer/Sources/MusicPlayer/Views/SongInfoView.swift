import SwiftUI
import MusicKit

public struct SongInfoView {
  let songTitle: String
  let artistName: String
  public init(_ songTitle: String,
              _ artistName: String) {
    self.songTitle = songTitle
    self.artistName = artistName
  }
}

extension SongInfoView: View {
  public var body: some View {
    VStack {
      SongTitleView(songTitle)
      ArtistNameView(artistName)
    }
  }
}
