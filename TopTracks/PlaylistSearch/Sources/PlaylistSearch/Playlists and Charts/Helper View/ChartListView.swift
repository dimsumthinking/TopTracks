import SwiftUI
import MusicKit
import Constants

struct ChartListView: View {
  let filteredPlaylists: [Playlist]
  @Environment(\.colorScheme) private var colorScheme
  private let columns = [GridItem(.adaptive(minimum: Constants.playlistGridGridSize * 3/4,
                                            maximum: Constants.playlistGridGridSize))]
  
  init(_ filteredPlaylists: MusicItemCollection<Playlist>) {
    self.filteredPlaylists = filteredPlaylists.map{$0}
  }
}

extension ChartListView {
  @ViewBuilder
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(filteredPlaylists) {playlist in
          if let artwork = playlist.artwork {
            NavigationLink {
              PlaylistSongsView(playlist: playlist)
                .navigationTitle(playlist.name)
            } label: {
              ArtworkImage(artwork,
                           width: Constants.playlistGridImageSize,
                           height: Constants.playlistGridImageSize)
            }
          }
        }
      }
    }
  }
}

struct ChartListView_Previews: PreviewProvider {
  static var previews: some View {
    ChartListView([])
  }
}
