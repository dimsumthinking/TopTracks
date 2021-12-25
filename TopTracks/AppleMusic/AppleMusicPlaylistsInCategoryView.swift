import SwiftUI
import MusicKit

struct AppleMusicPlaylistsInCategoryView {
  @StateObject private var playlistsInCategory: AppleMusicPlaylistsInCategory
}

extension AppleMusicPlaylistsInCategoryView {
  init(for category: AppleMusicCategory) {
    self.init(playlistsInCategory: AppleMusicPlaylistsInCategory(category))
  }
}

extension AppleMusicPlaylistsInCategoryView: View {
  var body: some View {
    List(playlistsWithArtwork) {playlist in
      NavigationLink {
        StationBuilderStage("Look through this list of songs. Tap on them to sample them if you like. If there are enough here that you like, tap the button below to create the station.") {
          VStack {
            Button("Create Station from this Playlist",
                   action: {})
              .buttonStyle(.bordered)
            AppleMusicPlaylistTracksPreviewView(playlist: playlist)
              .navigationTitle(Text(playlist.name))
              .navigationBarTitleDisplayMode(.inline)
          }
        }
        
      } label: {
        AppleMusicPlaylistBillboardView(playlist: playlist)
      }
    }
    .modifier(StationBuildCancellation())
  }
}

extension AppleMusicPlaylistsInCategoryView {
  private var playlistsWithArtwork: [Playlist] {
    playlistsInCategory
      .playlists
      .filter {playlist in playlist.artwork != nil}
  }
}

struct AppleMusicPlaylistsInCategoryView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicPlaylistsInCategoryView(for: .spatialAudio)
  }
}
