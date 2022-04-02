import SwiftUI
import MusicKit
import AVFAudio

struct StationSongPreview {
  let song: Song
  @Binding var currentSong: Song?
  @State private var isPlaying = false
}

extension StationSongPreview: View {
  var body: some View {
    HStack (alignment: .top) {
      if let artwork = song.artwork {
        ArtworkImage(artwork, width: songPreviewArtworkImageSize)
      }
      VStack (alignment: .leading) {
        Text(song.title)
          .font(.headline)
        Text(song.artistName)
          .font(.caption)
      }
      Spacer()
    }
    .border(currentSong == song ? Color.cyan : Color.clear)
    .contentShape(Rectangle())
    .onTapGesture {
      isPlaying.toggle()
      if isPlaying {
        currentSong = song
        songPreviewPlayer.play(song)
      } else {
        songPreviewPlayer.stop()
      }
    }
  }
}


//struct StationSongPreview_Previews: PreviewProvider {
//  static var previews: some View {
//    StationSongPreview()
//  }
//}
