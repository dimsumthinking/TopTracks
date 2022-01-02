//import SwiftUI
//import MusicKit
//
//struct AppleMusicPlaylistBillboardView {
//  let playlist: Playlist
//  @State private var artists = [""]
//}
//
//
//extension AppleMusicPlaylistBillboardView: View {
//  var body: some View {
//    return HStack(alignment: .top) {
//      playlist.playlistImage
//        .border(playlist.primaryColor.opacity(0.3))
//        .padding()
//      VStack(alignment: .leading, spacing: 20) {
//        Text(playlist.name)
//        AppleMusicFeaturedArtistView(artists: artists)
//      }
//      .foregroundColor(playlist.secondaryColor)
//      .padding()
//      Spacer()
//    }
//    .frame(maxWidth: .infinity)
//    .background(playlist.backgroundColor)
//    .onAppear {
//      Task {
//        let artistsPlaylist = try await playlist.with([.featuredArtists, .tracks])
//        if let artists = artistsPlaylist.featuredArtists {
//          self.artists = artists.map(\.name)
//        }
//      }
//    }
//  }
//}
//
//extension Playlist: AppleMusicArtworkDisplayable {}
