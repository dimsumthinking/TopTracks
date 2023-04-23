import SwiftUI
import ApplicationState
import PlaylistSearchShared

public struct PlaylistKindView {
  public init() {}
}

extension PlaylistKindView: View {
  public var body: some View {
    Grid(alignment: .leading) {
      ForEach(mainPlaylistKinds) { playlistKind in
        NavigationLink {
          if playlistKind.isChart {
            ChartChooserView(kind: playlistKind.musicCatalogChartKind)
              .navigationTitle(playlistKind.description)
          } else if playlistKind.hasHardCodedCategories {
            AppleMusicCategoryChooserView(categories: playlistKind.playlistCategories,
                                          playlistKind: playlistKind)
              .navigationTitle(playlistKind.description)
//          }  else if playlistKind == .classical {
//            Text("Searching for classical")
//              .navigationTitle(playlistKind.description)
          } else {
           PlaylistSearchRequestView()
          }
          
        } label: {
          GridRow {
            Image(systemName: playlistKind.sfSymbolName)
            Text(playlistKind.description)
          }
          .font(.title2)
          .padding(6)
        }
      }
    }
    .navigationTitle("Playlist Kinds")
  }
}

struct PlaylistKindView_Previews: PreviewProvider {
  static var previews: some View {
    PlaylistKindView()
  }
}
