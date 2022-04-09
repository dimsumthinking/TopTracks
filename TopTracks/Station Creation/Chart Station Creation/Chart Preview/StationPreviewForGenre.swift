import SwiftUI
import MusicKit

struct StationPreviewForGenre {
  let genre: Genre
  @State var songsInCategories: [SongInCategory] = []
}

extension StationPreviewForGenre: View {
  var body: some View {
    VStack {
      StationCreationForGenreChart(genre: genre,
                                   songsInCategories: songsInCategories)
    StationSongsPreview(songsInCategories: songsInCategories)
    }
    .onAppear {
      Task {
        songsInCategories = await StationFiller.rotation(for: genre)
      }
    }
    .navigationTitle("Top " + genre.name)
    .modifier(NewStationCancellation())
  }
}

//struct ChartPreviewCity_Previews: PreviewProvider {
//  static var previews: some View {
//    ChartPreviewCity()
//  }
//}


