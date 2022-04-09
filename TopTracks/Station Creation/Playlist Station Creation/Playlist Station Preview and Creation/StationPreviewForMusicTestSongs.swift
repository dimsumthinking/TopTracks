import SwiftUI
import MusicKit

struct StationPreviewForMusicTestSongs {
  let playlist: Playlist
  let musicTestSongs: MusicTestSongs
  @State var songsInCategories: [SongInCategory] = []
}

extension StationPreviewForMusicTestSongs: View {
  var body: some View {
    VStack {
      StationCreationForMusicTestSongs(playlist: playlist, songsInCategories: songsInCategories)
      StationSongsPreview(songsInCategories: songsInCategories)
    }
    .onAppear {
      Task {
        songsInCategories = await StationFiller.rotation(for: musicTestSongs)
      }
    }
    .navigationTitle(musicTestSongs.playlist.name)
    .modifier(NewStationCancellation())
  }
}



//struct ChartPreviewCity_Previews: PreviewProvider {
//  static var previews: some View {
//    ChartPreviewCity()
//  }
//}


