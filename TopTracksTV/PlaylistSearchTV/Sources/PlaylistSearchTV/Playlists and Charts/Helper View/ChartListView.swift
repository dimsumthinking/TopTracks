import SwiftUI
import MusicKit
import Constants

struct ChartListView: View {
  let filteredPlaylists: [Playlist]
  @Environment(\.colorScheme) private var colorScheme
  let columns = [GridItem(.adaptive(minimum: Constants.playlistGridGridSize,
                                    maximum: Constants.playlistGridGridSize))]
  
  init(_ filteredPlaylists: [Playlist]) {
    self.filteredPlaylists = filteredPlaylists
  }
}

extension ChartListView {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: Constants.playlistGridRowSpacing) {
        ForEach(filteredPlaylists) {playlist in
          if let artwork = playlist.artwork {
            NavigationLink(value: playlist) {
              Button {
                
              } label: {
                ArtworkImage(artwork,
                             width: Constants.playlistGridImageSize,
                             height: Constants.playlistGridImageSize)
                .padding()
                
              }
              .buttonStyle(.card)
              
            }
          }
        }
      }
    }
    .navigationDestination(for: Playlist.self) {playlist in

        PlaylistSongsView(playlist: playlist)
    }
    
  }
}

struct ChartListView_Previews: PreviewProvider {
  static var previews: some View {
    ChartListView([])
  }
}
