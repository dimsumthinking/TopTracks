import SwiftUI
import MusicKit

struct PlaylistListView {
  let filteredPlaylists: [Playlist]
  
  init(_ filteredPlaylists: [Playlist]) {
    self.filteredPlaylists = filteredPlaylists
  }
}

extension PlaylistListView: View {
  var body: some View {
    List(filteredPlaylists) {playlist in
      HStack(alignment: .top) {
        if let artwork = playlist.artwork {
          ArtworkImage(artwork,
                       width: Constants.playlistListImageSize,
                       height: Constants.playlistListImageSize)
        } else {
          Image(systemName: "mappin")
            .background(Color.secondary)
            .frame(width: Constants.playlistListImageSize,
                   height: Constants.playlistListImageSize)
        }
        VStack(alignment: .leading) {
          Text(playlist.name)
            .font(.headline);
          if let shortDescription = playlist.shortDescription {
            Text(shortDescription)
              .font(.caption)
              .foregroundColor(.secondary)
          }
        }
      }
    }
  }
}

struct PlaylistListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistListView([])
    }
}
