import SwiftUI
import MusicKit
import Constants
import Model


public struct SongWithEditableCategoryPreview: View {
  let song: Song
  let topTracksSong: TopTracksSong
  @Binding private var currentSong: Song?
  @Environment(\.colorScheme) private var colorScheme
  let isPlaying: Bool

  public init?(topTracksSong: TopTracksSong,
              currentSong: Binding<Song?>) {
    guard let song  = topTracksSong.song else { return nil }
    self.song = song
    self.topTracksSong = topTracksSong
    self._currentSong = currentSong
    self.isPlaying = currentSong.wrappedValue == song
  }
}

extension SongWithEditableCategoryPreview  {
  public var body: some View {
    HStack {
      SongPreview(song: song,
                  currentSong: $currentSong)
      Text("\(topTracksSong.title) \(topTracksSong.rotationCategory)")
    }
  }
}




