import SwiftUI
import MusicKit

struct ChartStationPreviewForGenre {
  let genre: Genre
  @State var songsInCategories: [SongInCategory] = []
}

extension ChartStationPreviewForGenre: View {
  var body: some View {
    StationSongsPreview(songsInCategories: songsInCategories)
    .onAppear {
      Task {
        songsInCategories = await ChartStationFiller.rotation(for: genre)
      }
    }
  }
}

//struct ChartPreviewCity_Previews: PreviewProvider {
//  static var previews: some View {
//    ChartPreviewCity()
//  }
//}


