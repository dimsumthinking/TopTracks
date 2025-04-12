import SwiftUI
import Constants
import MusicKit

struct SongPreviewInfo: View {
  let title: String
  let artistName: String
}

extension SongPreviewInfo {
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
      Text(artistName)
        .foregroundColor(.secondary)
    }
    .padding(.leading)
  }
}

