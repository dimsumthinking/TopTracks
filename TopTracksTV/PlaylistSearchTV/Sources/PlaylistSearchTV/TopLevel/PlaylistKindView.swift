import SwiftUI
import ApplicationState
import PlaylistSearchShared

public struct PlaylistKindView {
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  public init() {}
}

extension PlaylistKindView: View {
  public var body: some View {
    VStack {
      Spacer()
      LazyVGrid(columns: columns) {
        ForEach(mainPlaylistKinds) {playlistKind in
          NavigationLink(value: playlistKind) {
            Button {
              
            } label: {
              HStack {
                Image(systemName: playlistKind.sfSymbolName)
                  .padding()
                Spacer()
                Text(playlistKind.description)
                  .padding()
                Spacer()
              }
              .font(.headline)
              .padding()
            }
            .buttonStyle(.card)
          }
        }

      }
      Spacer()
    }
    .navigationDestination(for: PlaylistKind.self) {playlistKind in
      if playlistKind.isChart {
        ChartChooserView(kind: playlistKind.musicCatalogChartKind)
      } else if playlistKind.hasHardCodedCategories {
        AppleMusicCategoryChooserView(categories: playlistKind.playlistCategories,
                                      playlistKind: playlistKind)
      } else {
        PlaylistSearchRequestView()
      }
      
    }
  }
}

//extension PlaylistKindView: View {
//  public var body: some View {
//    Grid(alignment: .leading) {
//      ForEach(mainPlaylistKinds) { playlistKind in
//        NavigationLink {
//          if playlistKind.isChart {
//            ChartChooserView(kind: playlistKind.musicCatalogChartKind)
//              .navigationTitle(playlistKind.description)
//          } else if playlistKind.hasHardCodedCategories {
//            AppleMusicCategoryChooserView(categories: playlistKind.playlistCategories,
//                                          playlistKind: playlistKind)
//              .navigationTitle(playlistKind.description)
////          }  else if playlistKind == .classical {
////            Text("Searching for classical")
////              .navigationTitle(playlistKind.description)
//          } else {
//           PlaylistSearchRequestView()
//          }
//
//        } label: {
//
//          GridRow {
//            Image(systemName: playlistKind.sfSymbolName)
//            Text(playlistKind.description)
//          }
//          .font(.title2)
//          .padding(6)
//        }
//      }
//    }
//    .navigationTitle("Playlist Kinds")
//  }
//}

struct PlaylistKindView_Previews: PreviewProvider {
  static var previews: some View {
    PlaylistKindView()
  }
}
