import SwiftUI
import ApplicationState
import AudioToolbox
import MusicKit
import Constants

public struct MainPlayerView {
  @State private var currentSong: Song?
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  public init() {}
}

extension MainPlayerView: View {
  public var body: some View {
    VStack {
      HStack {
        Button {
          CurrentActivity.shared.endImporting()
        } label: {
          Text("\(Image(systemName: "arrow.left")) Stations")
        }
        Spacer()

      }
      Spacer()
      if let currentSong {
                    SongTextInfo(currentSong: currentSong)

      } else {
        Text("Main Player")
      }
Spacer()
    }
        .onChange(of: queue.currentEntry) { entry in
          if let entry {
            CurrentSong.shared.setCurrentSong(using: entry)
          }
        }
        .onAppear {
          currentSong = CurrentSong.shared.song
        }
        .task {
          await subscribeToCurrentSong()
        }
  }
}

//extension MainPlayerView: View {
//  public var body: some View {
//    VStack {
//      if let currentSong {
//        NavigationStack {
//          VStack {
//            AlbumArt(artwork: CurrentSong.shared.artwork )
//
//            SongTextInfo(currentSong: currentSong)
//
//            Spacer()
//
//            SongScrubberView(currentSong: currentSong)
//              .padding()
//              .font(.headline)
////              .tint(.primary)
//            Spacer()
//            ControlPanel()
//            Spacer()
//          }
//          .navigationTitle(CurrentStation.shared.topTracksStation?.stationName ?? "Now Playing")
//          .toolbar {
//            if CurrentStation.shared.canShowRating {
//              ToolbarItem(placement: .navigationBarTrailing) {
//                SongRatingView()
//
//              }
//            }
////            ToolbarItem(placement: .navigationBarLeading) {
////              SleepTimerView()
////            }
//          }
//        }
//
//      }
//
//      else {
//        ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
//      }
//
//
//    }
//    .onChange(of: queue.currentEntry) { entry in
//      if let entry {
//        CurrentSong.shared.setCurrentSong(using: entry)
//      }
//    }
//    .onAppear {
//      currentSong = CurrentSong.shared.song
//    }
//    .task {
//      await subscribeToCurrentSong()
//    }
//
//  }
//}

extension MainPlayerView {
  private func subscribeToCurrentSong() async {
    do {
      let songs = try CurrentSong.shared.currentSongStream()
      for await song in songs {
        self.currentSong = song
      }
    } catch {
      print(error)
    }
  }
}


