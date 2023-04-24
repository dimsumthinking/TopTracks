import SwiftUI
import MusicKit

struct SongTextInfo {
  let currentSong: Song
}

// no popover

extension SongTextInfo: View {
  var body: some View {
      VStack {
        Text(currentSong.title)
          .multilineTextAlignment(.center)
          .lineLimit(2)
        Text(currentSong.artistName)
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)
          .lineLimit(2)
      }
    .padding()
    .padding(.horizontal)
  }
}


//extension SongTextInfo: View {
//  var body: some View {
//    HStack {
//      VStack(alignment: .leading) {
//        Text(currentSong.title)
//          .font(.headline)
//        Text(currentSong.artistName)
//          .foregroundColor(.secondary)
//      }
//      Spacer()
//      Button {
//
//      } label: {
//        Image(systemName: "ellipsis.circle.fill")
//          .font(.title)
//          .foregroundColor(.secondary)
//      }
//    }
//    .padding()
//    .padding(.horizontal)
//  }
//}
