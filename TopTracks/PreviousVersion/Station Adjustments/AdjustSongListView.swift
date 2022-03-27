import SwiftUI

struct AdjustSongListView {
  @ObservedObject var songs: MusicTestSongs
  let currentCategory: RotationCategory
  let targetCategory: RotationCategory
  let up: Bool?
  @Binding var cantMoveOn: Bool
}

extension AdjustSongListView: View {
  var body: some View {
    List {
      ForEach(songList) {result in
        HStack {
          result.rotationCategory.symbol
            .font(.largeTitle)
            .padding()
          
          VStack(alignment: .leading) {
            Text(result.song.title).bold()
            Text(result.song.artistName)
          }
          Spacer()
          if let up = up {
            Image(systemName: up ? "arrow.up" : "arrow.down")
              .foregroundColor(.secondary)
              .font(.largeTitle)
              .padding()
          }
        }
        .foregroundColor(result.rotationCategory.color)
        .contentShape(Rectangle())
        .onTapGesture {
          if let up = up {
            let category = up ? targetCategory : currentCategory
            songs.setCategory(of: result, to: targetCategory)
            cantMoveOn
            = (songs.numberOfSongs(in: category) < songs.minimumNumberOfSongsPerCategory)
            || (songs.numberOfSongs(in: category) > songs.maximumNumberOfSongsPerCategory)
          }
        }
      }
    }
  }
}

extension AdjustSongListView {
  private var songList: [MusicTestResult] {
    guard let up = up,
          up else { return songs.songs(in: currentCategory)}
    var categories = [currentCategory]
    var numberNeeded = songs.maximumNumberOfSongsPerCategory
    - songs.numberOfSongs(in: targetCategory)
    - songs.numberOfSongs(in: currentCategory)
    if numberNeeded <= 0 {
      return songs.songs(in: currentCategory)
    } else {
      let nextCategory = currentCategory.next
      guard nextCategory != .notIncluded else {
        return songs.songs(in: currentCategory)}
      categories.append(nextCategory)
      numberNeeded -= songs.numberOfSongs(in: nextCategory)
      if numberNeeded <= 0 {
        return songs.songs(categories: categories)
      } else {
        let finalCategory = nextCategory.next
        guard finalCategory != .notIncluded else {return songs.songs(categories: categories)}
        categories.append(finalCategory)
        return songs.songs(categories:categories)
      }
    }
    
    
    
  }
}
