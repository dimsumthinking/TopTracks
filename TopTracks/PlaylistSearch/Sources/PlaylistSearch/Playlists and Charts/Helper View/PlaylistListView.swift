import SwiftUI
import MusicKit
import Constants

struct PlaylistListView {
  let filteredPlaylists: [Playlist]
  
  init(_ filteredPlaylists: [Playlist]) {
    self.filteredPlaylists = filteredPlaylists
  }
}

extension PlaylistListView: View {
  var body: some View {
    List(filteredPlaylists) {playlist in
      if let artwork = playlist.artwork,
         let backgroundColor = artwork.backgroundColor {
        HStack(alignment: .top) {
          NavigationLink {
            PlaylistSongsView(playlist: playlist)
              .navigationTitle(playlist.name)
          } label: {
            ArtworkImage(artwork,
                         width: Constants.playlistListImageSize,
                         height: Constants.playlistListImageSize)
            VStack(alignment: .leading) {
              Text(playlist.name)
                .font(.headline)
              if let curatorName = playlist.curatorName {
                Text(curatorName)
                  .font(.subheadline)
              }
              if let shortDescription = playlist.shortDescription {
                Text(shortDescription)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
          }
        }
        .listRowBackground(LinearGradient(colors: [Color(backgroundColor).opacity(0.9), Color(backgroundColor).opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
      }
    }
  }
}

struct PlaylistListView_Previews: PreviewProvider {
  static var previews: some View {
    PlaylistListView([])
  }
}
