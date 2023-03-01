import SwiftUI
import MusicKit
import Constants

struct PlaylistGridView {
  let filteredPlaylists: [Playlist]
  
  init(_ filteredPlaylists: [Playlist]) {
    self.filteredPlaylists = filteredPlaylists
  }
}

extension PlaylistGridView: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.playlistGridGridSize,
                                             maximum: Constants.playlistGridGridSize))],
                spacing: Constants.playlistGridRowSpacing) {
        ForEach(filteredPlaylists) {playlist in
          VStack {
            if let artwork = playlist.artwork {
              ArtworkImage(artwork,
                           width: Constants.playlistGridImageSize,
                           height: Constants.playlistGridImageSize)
            } else {
              Image(systemName: "mappin")
                .background(Color.secondary)
                .frame(width: Constants.playlistGridImageSize,
                       height: Constants.playlistGridImageSize)
            }
            Text(shortenedNameFor(playlist: playlist))
              .lineLimit(1)
          }
        }
      }
    }
  }
}

struct PlaylistGridView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistGridView([])
    }
}
