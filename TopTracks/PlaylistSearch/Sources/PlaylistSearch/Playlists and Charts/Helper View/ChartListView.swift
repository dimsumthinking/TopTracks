import SwiftUI
import MusicKit
import Constants

struct ChartListView {
  let filteredPlaylists: [Playlist]
  @Environment(\.colorScheme) private var colorScheme
  private let columns = [GridItem(.adaptive(minimum: Constants.playlistGridGridSize * 3/4,
                                            maximum: Constants.playlistGridGridSize))]
  
  init(_ filteredPlaylists: [Playlist]) {
    self.filteredPlaylists = filteredPlaylists
  }
}

extension ChartListView: View {
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
//    
//    
//    List(filteredPlaylists) {playlist in
//      if let artwork = playlist.artwork,
//         let backgroundColor = artwork.backgroundColor {
//        HStack(alignment: .top) {
//          NavigationLink {
//            PlaylistSongsView(playlist: playlist)
//              .navigationTitle(playlist.name)
//          } label: {
//            ArtworkImage(artwork,
//                         width: Constants.playlistListImageSize,
//                         height: Constants.playlistListImageSize)
//            VStack(alignment: .leading) {
//              Text(playlist.name)
//                .font(.headline)
//              if let curatorName = playlist.curatorName {
//                Text(curatorName)
//                  .font(.subheadline)
//              }
//              if let shortDescription = playlist.shortDescription {
//                Text(shortDescription)
//                  .lineLimit(3)
//                  .font(.caption)
//                  .foregroundColor(.secondary)
//              }
//            }
//          }
//        }
//        .listRowBackground(LinearGradient(colors: [
//          ColorConstants.gradientStartColor(backgroundColor: backgroundColor,
//                                            colorScheme: colorScheme),
//          ColorConstants.gradientEndColor(backgroundColor: backgroundColor,
//                                          colorScheme: colorScheme)],
//                                          startPoint: .topLeading,
//                                          endPoint: .bottomTrailing))
//        .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
//
//      }
//    }
//    .listStyle(.plain)

  }
}

struct ChartListView_Previews: PreviewProvider {
  static var previews: some View {
    ChartListView([])
  }
}
