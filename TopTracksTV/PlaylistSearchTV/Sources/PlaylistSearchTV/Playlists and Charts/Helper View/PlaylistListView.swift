import SwiftUI
import MusicKit
import Constants

struct PlaylistListView: View {
  let filteredPlaylists: [Playlist]
  @Environment(\.colorScheme) private var colorScheme
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  
  init(_ filteredPlaylists: [Playlist]) {
    self.filteredPlaylists = filteredPlaylists
  }
}

extension PlaylistListView {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(filteredPlaylists) {playlist in
          if let artwork = playlist.artwork {
            NavigationLink(value: playlist) {
              Button {
                
              } label: {
                HStack(alignment: .top) {
                  ArtworkImage(artwork,
                               width: Constants.playlistListImageSize,
                               height: Constants.playlistListImageSize)
                  .padding()
                  VStack(alignment: .leading) {
                    Text(playlist.name)
//                    if let curator = playlist.curatorName {
//                      Text(curator.description)
//                    }
                    
                    
                    if let shortDescription = playlist.shortDescription {
                      Text(shortDescription)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                  }
                  .padding()
                  Spacer()
                  
                }
                .padding()
              }
              #if !os(macOS)
              .buttonStyle(.card)
              #endif
            }
          }
        }
      }
    }
    .navigationDestination(for: Playlist.self) {playlist in

      
    }
      
      
    }
  }
  
  struct PlaylistListView_Previews: PreviewProvider {
    static var previews: some View {
      PlaylistListView([])
    }
  }
