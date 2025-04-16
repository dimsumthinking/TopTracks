import SwiftUI
import MusicKit
import Constants
import Model


public struct SongWithEditableCategoryPreview: View {
  let song: Song
  let topTracksSong: TopTracksSong
  @Binding private var currentSong: Song?
//  @Environment(\.colorScheme) private var colorScheme
//  let isPlaying: Bool
//  let initialCategory: RotationCategory
  @State private var selectedCategory: RotationCategory

  public init?(topTracksSong: TopTracksSong,
              currentSong: Binding<Song?>) {
    guard let song  = topTracksSong.song else { return nil }
    self.song = song
    self.topTracksSong = topTracksSong
    self._currentSong = currentSong
//    self.isPlaying = currentSong.wrappedValue == song
//    self.initialCategory = topTracksSong.rotationCategory
    self.selectedCategory = topTracksSong.rotationCategory
  }
}

extension SongWithEditableCategoryPreview  {
  public var body: some View {
    HStack {
      SongPreview(song: song,
                  currentSong: $currentSong)
      Picker(selection: $selectedCategory) {
        ForEach(stationAllCategories) { category in
          Image(systemName: category.icon)
        }
      } label: {
//        Text("\(selectedCategory)")
      }
      .pickerStyle(.menu)
    }
    .onChange(of: selectedCategory) {
      topTracksSong.rotationCategory = selectedCategory
    }
  }
}




