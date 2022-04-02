import SwiftUI
import MusicKit

struct ChartStationPreviewForPlaylist {
  let playlist: Playlist
  @State var songsInCategories: [SongInCategory] = []
}

extension ChartStationPreviewForPlaylist: View {
  var body: some View {
    StationSongsPreview(songsInCategories: songsInCategories)
    .onAppear {
      Task {
        songsInCategories = await ChartStationFiller.rotation(for: playlist)
      }
    }
  }
}

//struct ChartPreviewCity_Previews: PreviewProvider {
//  static var previews: some View {
//    ChartPreviewCity()
//  }
//}


