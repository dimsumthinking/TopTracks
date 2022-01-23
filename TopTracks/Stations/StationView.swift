import SwiftUI
import MusicKit

struct StationView {
  let station: TopTracksStation
  @State private var songs: [Song] = []
  @State private var song: Song?
}

extension StationView: View {
    var body: some View {
      VStack {
        Text(song?.title ?? "no title")
//        song.map{AppleMusicSongView(song: $0)}
        AppleMusicSongsView(songs: songs)
//      StationSongsView(songs: songs)
      }
      .onAppear {
        self.song = station.stacks.first?.songs.first?.song
        self.songs = getSongs()
        print("Loading", self.songs.count)
        }
    }
}

extension StationView {
  func getSongs() -> [Song] {
     var songs = station.stacks.flatMap(\.songs).compactMap(\.song)
    songs.append(songs[2])
    return songs
  }
}

//struct StationView_Previews: PreviewProvider {
//    static var previews: some View {
//        StationView()
//    }
//}
