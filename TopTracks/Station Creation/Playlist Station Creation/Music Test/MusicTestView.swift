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
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  
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
            if !noPreviousSong {
              HStack {
                if let artwork = songs[index - 1].song.artwork {
                  ArtworkImage(artwork, width: backButtonArtworkImageSize).padding(.horizontal)
                } else {
                  Image(systemName: "arrow.left").padding()
                }
                Text(" \(songs[index - 1].song.title)")
                Spacer()
              }
            } else {
              HStack {
                Text(" ")
                Spacer().padding(.trailing)
              }
            }
          }
          .disabled(noPreviousSong)
          .buttonStyle(.bordered)
          .padding(.horizontal)
          .padding(.horizontal)
          ProgressView("",
                       value: Double(songs.numberOfRatedSongs),
                       total: Double(songs.numberOfSongsToBeRated))
            .padding()
        }
      } else {
        if  isSubscribed {
          Button("You've already hand-crafted\n\(playlist.name) \n Tap to listen now",
                 action: playStation)
        } else {
          MusicTestOverview(testIsRunning: $testIsRunning,
                            action: playSong,
                            count: songs.testResults.count)
        }
      }
    }
    .navigationTitle(playlist.name)
    .navigationBarTitleDisplayMode(.inline)
    .modifier(MusicTestCancellation(finish: finishPlaylist))
    .onDisappear {
      songPreviewPlayer.audioPlayer = nil
    }
    .onAppear {
      playlistIDs = stations.filter {station in
        station.stationType == .playlist
      }.compactMap(\.playlistInfo).map(\.playlistID)
    }
    .sheet(isPresented: $show10Alert){
      Popup10(next: nextSong,
              finish: finishPlaylist,
              show10Alert: $show10Alert)
    }
    .sheet(isPresented: $show25Alert){
      Popup25(next: nextSong,
              show25Alert: $show25Alert,
              moveOn: $moveOn)
    }
  }
}

extension MusicTestView {
  private var isSubscribed: Bool {
    playlistIDs.contains(playlist.id.rawValue)
  }
  private func playStation() {
    topTracksStatus.isCreatingNew = false
    
    StationCreationCheckIfExists.playStation(with: playlist.id,
                                             in: stations,
                                             stationType: .playlist,
                                             currentlyPlaying: currentlyPlaying)
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
  
  private func finishPlaylist() {
    let limit = index < 25 ? 25 : 40
    while songs.numberOfRatedSongs < limit
            && songs.testResults.indices.contains(index + 1) {
      index += 1
      songs[index].rotationCategory = standardRotationCategories.randomElement() ?? .spice
    }
    moveOn = true
  }
}

