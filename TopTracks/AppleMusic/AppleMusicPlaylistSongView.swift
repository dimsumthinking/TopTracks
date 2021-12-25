import Foundation
import SwiftUI
import MusicKit

struct AppleMusicPlaylistSongView {
  let song: Song
}

extension AppleMusicPlaylistSongView: View {
  var body: some View {
    HStack(alignment: .top) {
      VStack {
        song.playlistImage
          .border(Color.primary.opacity(0.3))
          .padding()
      }
      VStack(alignment: .leading) {
        Text(song.title)
          .padding(.top)
        Text(song.artistName)
          .foregroundColor(Color.secondary)
          .padding(.top, 4)
      }
      Spacer()
    }
      .frame(maxWidth: .infinity)
  }
}

//extension PlaylistSongView: View {
//  var body: some View {
//    HStack(alignment: .top) {
//      VStack {
//        song.playlistImage
//          .border(song.primaryColor.opacity(0.3 ))
//          .padding()
//      }
//      VStack(alignment: .leading) {
//        Text(song.title)
//          .foregroundColor(song.primaryColor)
//          .padding(.top)
//        Text(song.artistName)
//          .foregroundColor(song.secondaryColor)
//          .padding(.top, 4)
//      }
//      Spacer()
//    }
//    .background(song.backgroundColor.opacity(0.8))
//
//      .frame(maxWidth: .infinity)
//  }
//}

extension Song: AppleMusicArtworkDisplayable {}
