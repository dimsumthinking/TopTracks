import SwiftUI
import MusicKit

struct MusicTestView {
  private let playlist: Playlist
  @StateObject private var songs: MusicTestSongs
  @State private var testIsRunning = false
  @State private var index = 0
  @State private var moveOn = false
}

extension MusicTestView {
  init(for playlist: Playlist) {
    self.init(playlist: playlist,
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
                                  next: nextSong)
          NavigationLink(isActive: $moveOn) {
           StationPreviewForMusicTestSongs(playlist: playlist,
                                           musicTestSongs: songs)
          } label: {
            EmptyView()
          }
          ProgressView("", value: songs.numberOfRatedSongs, total: songs.numberOfSongsToBeRated)
            .padding()
        }
      } else {
        MusicTestOverview(testIsRunning: $testIsRunning,
                          action: playSong,
                          count: songs.testResults.count)
        
      }
    }
    .navigationTitle(playlist.name)
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
    .onDisappear {
      songPreviewPlayer.audioPlayer = nil
    }
  }
}

extension MusicTestView {
  private func playSong() {
    songPreviewPlayer.play(songs[index].song)
  }
  
  private func nextSong() {
    songPreviewPlayer.audioPlayer = nil
    if songs.testResults.indices.contains(index + 1)
        && songs.numberOfRatedSongs < songs.numberOfSongsToBeRated {
      index += 1
      playSong()
    } else {
      moveOn = true
    }
  }
}

