import SwiftUI
import MusicKit
import Constants


public struct SongPreview {
  let song: Song
  @Binding private var currentSong: Song?
  @Environment(\.colorScheme) private var colorScheme
  let isPlaying: Bool
  
  public init(song: Song,
              currentSong: Binding<Song?>) {
    self.song = song
    self._currentSong = currentSong
    self.isPlaying = currentSong.wrappedValue == song
  }
}

extension SongPreview: View {
  public var body: some View {
    HStack {
      if let artwork = song.artwork {
        ArtworkImage(artwork,
                     width: Constants.songListImageSize,
                     height: Constants.songListImageSize)
        .border(isPlaying ? ColorConstants.accentColor(for: colorScheme) : Color.clear, width: 3)
      } else {
        Image(systemName: "music.note")
          .background(Color.secondary)
          .frame(width: Constants.songListImageSize,
                 height: Constants.songListImageSize)
          .border(isPlaying ? ColorConstants.accentColor(for: colorScheme) : Color.clear, width: 3)
      }
      VStack(alignment: .leading) {
        Text(song.title)
        Text(song.artistName)
          .foregroundColor(.secondary)
      }
      .padding(.leading)
    }
    .contentShape(Rectangle())
    .onTapGesture {
      if !isPlaying {
        songPreviewPlayer.play(song)
        currentSong = song
      } else {
        songPreviewPlayer.stop()
        currentSong = nil
      }
    }
  }
}

