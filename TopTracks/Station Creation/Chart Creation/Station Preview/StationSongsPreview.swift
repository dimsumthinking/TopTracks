import SwiftUI
import MusicKit

struct StationSongsPreview {
  let songsInCategories: [SongInCategory]
  @State private var currentSong: Song?
}

extension StationSongsPreview: View {
  var body: some View {
    List {
      ForEach(standardRotationCategories) {category in
        Section(category.rotationLevel) {
          ForEach(songsIn(category: category)) {song in
            StationSongPreview(song: song,
            currentSong: $currentSong)
          }
        }
      }
    }
    .onDisappear {
      songPreviewPlayer.stop()
    }
  }
}

extension StationSongsPreview {
  private func songsIn(category: RotationCategory) -> [Song] {
    songsInCategories.filter{category == $0.rotationCategory}.map(\.song)
  }
}

//struct StationSongsPreview_Previews: PreviewProvider {
//  static var previews: some View {
//    StationSongsPreview()
//  }
//}
