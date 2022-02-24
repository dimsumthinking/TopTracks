//import SwiftUI
//import MusicKit
//
//
//struct OnBoardingPlaylistView {
//  @StateObject private var playlistsInCategory: AppleMusicPlaylistsInCategory
//}
//
//extension OnBoardingPlaylistView {
//  init(for category: AppleMusicCategory) {
//    self.init(playlistsInCategory: AppleMusicPlaylistsInCategory(category))
//  }
//}
//
//extension OnBoardingPlaylistView: View {
//    var body: some View {
//      List(playlistsInCategory.playlists) {playlist in
//        NavigationLink {
//          OnBoardingSongSelectionView(playlist: playlist)
//        } label: {
//          AppleMusicPlaylistBillboardView(for: playlist)
//        }
//      }
//      .navigationTitle("Choose a Playlist")
//      .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
