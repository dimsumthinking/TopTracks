import SwiftUI
import MusicKit
import Constants


public struct SongPreview: View {
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

extension SongPreview  {
  public var body: some View {
    HStack {
      SongPreviewArtwork(artwork: song.artwork)
        .border(isPlaying ? ColorConstants.accentColor(for: colorScheme) : Color.clear, width: 3)
      SongPreviewInfo(title: song.title,
                      artistName: song.artistName)
      Spacer()
    }
    .contentShape(Rectangle())
    .onTapGesture {
      playSong()
    }
  }
}

extension SongPreview {
  public func playSong() {
    if !isPlaying {
      songPreviewPlayer.play(song)
      currentSong = song
    } else {
      songPreviewPlayer.stop()
      currentSong = nil
    }
  }
}

