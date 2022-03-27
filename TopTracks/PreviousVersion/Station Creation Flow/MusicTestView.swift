import SwiftUI
import MusicKit

struct MusicTestView {
  private let playlistName: String
  @StateObject private var songs: MusicTestSongs
  @State private var testIsRunning = false
  @State private var index = 0
  @State private var songIsRated = false
  @State private var moveOn = false
}

extension MusicTestView {
  init(for playlist: Playlist) {
    self.init(playlistName: playlist.name,
              songs: MusicTestSongs(playlist))
  }
}

extension MusicTestView: View {
  var body: some View {
//    ScrollView {
      VStack {
        if testIsRunning {
          VStack {
            SongArtAndInfoView(song: songs[index].song)
            MusicTestSongRatingView(category: $songs[index].rotationCategory,
                                    songIsRated: $songIsRated)
            NavigationLink(isActive: $moveOn) {
              StandardStackRefinementView(songs: songs,
                                  category: .power)
            } label: {
              EmptyView()
            }
            Button(action: nextSong){
              Text("Next")
                .padding()
                .padding(.horizontal)
            }
            .disabled(!songIsRated)
            .padding(30)
            .buttonStyle(.borderedProminent)
//            .padding()
            ProgressView("", value: Double(index + 1), total: Double(songs.count + 1))
              .padding(.horizontal)
          }
        } else {
          MusicTestOverview(testIsRunning: $testIsRunning,
                            action: playSong,
                            count: songs.testResults.count)
          
        }
      }
//    }
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
      musicTestPreviewPlayer.audioPlayer = nil
      moveOn = true
    }
  }
}

