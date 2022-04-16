import SwiftUI
import MusicKit

struct MusicTestView {
  private let playlist: Playlist
  @StateObject private var songs: MusicTestSongs
  @State private var testIsRunning = false
  @State private var index = 0
  @State private var moveOn = false
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @State private var playlistIDs: [String] = []
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  @State private var noPreviousSong:  Bool = true
  @State private var hasShown10: Bool = false
  @State private var show10Alert: Bool = false
  @State private var hasShown25: Bool = false
  @State private var show25Alert: Bool = false
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
          .padding(.bottom)
            Button(action: previousSong){
              HStack {
                Spacer()
              Image(systemName: "arrow.left")
                if !noPreviousSong {
                  Text(" \(songs[index - 1].song.title)")
                }
                Spacer() 
              }
                .padding(.horizontal)
            }
            .disabled(noPreviousSong)
            .buttonStyle(.bordered)
            .padding(.horizontal)
            .padding(.leading)
          ProgressView("", value: songs.numberOfRatedSongs, total: songs.numberOfSongsToBeRated)
            .padding()
        }
      } else {
        if playlistIDs.contains(playlist.id.rawValue) {
          Button("You've already hand-crafted\n\(playlist.name)"){topTracksStatus.isCreatingNew = false}
        } else {
        MusicTestOverview(testIsRunning: $testIsRunning,
                          action: playSong,
                          count: songs.testResults.count)
        }
      }
    }
    .navigationTitle(playlist.name)
    .navigationBarTitleDisplayMode(.inline)
    .modifier(MusicTestCancellation())
    .onDisappear {
      songPreviewPlayer.audioPlayer = nil
    }
    .onAppear {
      playlistIDs = stations.filter {station in
        station.stationType == .playlist
      }.compactMap(\.playlistInfo).map(\.playlistID)
    }
    .sheet(isPresented: $show10Alert){
      Popup10(next: nextSong, show10Alert: $show10Alert)
    }
    .sheet(isPresented: $show25Alert){
      Popup25(next: nextSong,
              show25Alert: $show25Alert,
              moveOn: $moveOn)
    }
  }
}

extension MusicTestView {
  private func playSong() {
    songPreviewPlayer.play(songs[index].song)
  }
  
  private func nextSong() {
    guard songs.numberOfRatedSongs != 10 || hasShown10 == true else {
      hasShown10 = true
      show10Alert = true
      return
    }
    guard songs.numberOfRatedSongs != 25 || hasShown25 == true else {
      hasShown25 = true
      if songs.numberOfSongsToBeRated > 5  {
        show25Alert = true
      }
      return
    }
    songPreviewPlayer.audioPlayer = nil
    if songs.testResults.indices.contains(index + 1)
        && songs.numberOfRatedSongs < songs.numberOfSongsToBeRated {
      index += 1
      playSong()
      noPreviousSong = (index <= 0)
    } else {
      moveOn = true
    }
  }
  private func previousSong() {
    songPreviewPlayer.audioPlayer = nil
    if index > 0 {
      index -= 1
      playSong()
      noPreviousSong = (index <= 0)
    }
  }
}

