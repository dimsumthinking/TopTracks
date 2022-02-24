import SwiftUI
import MusicKit

struct MusicTestView {
  private let playlistName: String
  @StateObject private var songs: MusicTestSongs
  @State private var testIsRunning = false
  @State private var index = 0
  @State private var songIsRated = false
  @State private var finished = false
}

extension MusicTestView {
  init(for playlist: Playlist) {
    self.init(playlistName: playlist.name,
              songs: MusicTestSongs(playlist))
  }
}

extension MusicTestView: View {
  var body: some View {
    VStack {
      if testIsRunning {
        VStack {
          SongArtAndInfoView(song: songs[index].song)
          MusicTestSongRatingView(category: $songs[index].rotationcategory,
                                  songIsRated: $songIsRated
          )
          Button("Next",
                 action: nextSong)
          .disabled(!songIsRated)
          ProgressView("", value: Double(index + 1), total: Double(songs.count + 1))
            .padding(.horizontal)
        }
      } else {
        if finished {
          Text("Finished")
        } else {
          MusicTestOverview(testIsRunning: $testIsRunning,
                            action: playSong)
        }
      }
    }
    .navigationTitle(playlistName)
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
    .onDisappear {
      musicTestPreviewPlayer.audioPlayer = nil
    }
  }
}

extension MusicTestView {
  private func playSong() {
    musicTestPreviewPlayer.play(songs[index])
  }
  
  private func nextSong() {
    if songs.testResults.indices.contains(index + 1) {
      index += 1
      songIsRated = false
      playSong()
    } else {
      testIsRunning = false
      finished = true
    }
  }
}




//  @Environment(\.managedObjectContext) private var viewContext
//  @FetchRequest(entity: TopTracksStation.entity(),
//                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
//                                                   ascending: true)]) private var stations: FetchedResults<TopTracksStation>
//  @EnvironmentObject private var topTracksStatus: TopTracksStatus



