import SwiftUI
import MusicKit

struct StationView {
  let station: TopTracksStation
  @State var isRefreshed = false
  @ObservedObject var queue = ApplicationMusicPlayer.shared.queue
  let player = ApplicationMusicPlayer.shared
  @ObservedObject var state = ApplicationMusicPlayer.shared.state
  private(set) static var currentStationID =  UUID()
}

extension StationView: View {
  var body: some View {
    VStack {
      Text(station.stationName)
        .font(.headline)
      Spacer()
      if let artwork = queue.currentEntry?.artwork {
        ArtworkImage(artwork,
                     width: UIScreen.main.bounds.width * 2 / 3,
                     height: UIScreen.main.bounds.width * 2 / 3)
          .border(Color.primary.opacity(0.3))
          .padding()
      }
      if let currentSong = currentSong {
        Text(currentSong.title)
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
          .font(.title2)
        Text(currentSong.artistName)
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
        Spacer()
        SongScrubberView(currentSong: currentSong)
      }
      
      HStack {
        Spacer()
        Button(action: {Task{try await player.skipToPreviousEntry()}}){
          Image(systemName: "backward.fill")
        }
        Spacer()
        Button(action: {Task{try await playOrPause()}}){
          Image(systemName: state.playbackStatus == .playing ? "pause.fill" : "play.fill")
        }
        Spacer()
        Button(action: {Task{try await player.skipToNextEntry()}}){
          Image(systemName: "forward.fill")
        }
        Spacer()
      }
      .font(.title)
      .foregroundColor(.primary)
      .padding(.vertical)
      SystemVolumeSlider()
        .frame(height: 20)
        .padding()
        .accentColor(.secondary)
        .padding(.horizontal)
      Spacer()
    }
    .onAppear {
//      if StationView.currentStationID != station.stationID {
//        ApplicationMusicPlayer.shared.queue = musicQueue(for: station)
//        Task {try await ApplicationMusicPlayer.shared.prepareToPlay()
//          try await player.play()
//        }
//      }
      StationView.currentStationID = station.stationID
    }
//    .navigationTitle(station.stationName)
  }
}


@MainActor
extension StationView {
  private func playOrPause() async throws {
    switch state.playbackStatus {
    case .playing:
      player.pause()
    case .paused:
      try await player.play()
    default:
      print("Should be unreachable")
    }
  }
}

extension StationView {
  private var currentSong: Song? {
    guard let item =  queue.currentEntry?.item else {return nil}
    switch item {
    case .song(let innerSong):
      station.markAsPlayed(songID: innerSong.id.rawValue)
      return innerSong
    default:
      return nil
    }
  }
}

//
//import SwiftUI
//import MusicKit
//
//struct StationView {
//  let station: TopTracksStation
//  @State var isRefreshed = false
//  @ObservedObject var queue = ApplicationMusicPlayer.shared.queue
//  let player = ApplicationMusicPlayer.shared
//  @ObservedObject var state = ApplicationMusicPlayer.shared.state
//  @State var isPlaying: Bool
//  private static var currentStationID =  UUID()
//}
//
//extension StationView: View {
//  var body: some View {
//    VStack {
//      Spacer()
//      if let artwork = queue.currentEntry?.artwork {
//        ArtworkImage(artwork,
//                     width: UIScreen.main.bounds.width * 2 / 3,
//                     height: UIScreen.main.bounds.width * 2 / 3)
//          .border(Color.primary.opacity(0.3))
//          .padding()
//      }
//      if let currentSong = currentSong {
//        Text(currentSong.title)
//          .multilineTextAlignment(.center)
//          .foregroundColor(.secondary)
//          .font(.title2)
//        Text(currentSong.artistName)
//          .multilineTextAlignment(.center)
//          .foregroundColor(.secondary)
//        Spacer()
//        SongScrubberView(currentSong: currentSong,
//                         isPlaying: $isPlaying)
//      }
//
//      HStack {
//        Spacer()
//        Button(action: {Task{try await player.skipToPreviousEntry()}}){
//          Image(systemName: "backward.fill")
//        }
//        Spacer()
//        Button(action: {Task{try await playOrPause()}}){
//          Image(systemName: isPlaying ? "pause.fill" : "play.fill")
//        }
//        Spacer()
//        Button(action: {Task{try await player.skipToNextEntry()}}){
//          Image(systemName: "forward.fill")
//        }
//        Spacer()
//      }
//      .font(.title)
//      .foregroundColor(.primary)
//      .padding(.vertical)
//      SystemVolumeSlider()
//        .frame(height: 20)
//        .padding()
//        .accentColor(.secondary)
//        .padding(.horizontal)
//      Spacer()
//    }
//    .onAppear {
//      if StationView.currentStationID != station.stationID {
//        ApplicationMusicPlayer.shared.queue = musicQueue(for: station)
//        Task {try await ApplicationMusicPlayer.shared.prepareToPlay()
//          isPlaying = true
//          try await player.play()
//        }
//      }
//      StationView.currentStationID = station.stationID
//    }
//    .navigationTitle(station.stationName)
//  }
//}
//
//
//@MainActor
//extension StationView {
//  private func playOrPause() async throws {
//    if isPlaying {
//      player.pause()
//      isPlaying = false
//    } else {
//      try await player.play()
//      isPlaying = true
//    }
//    print(ApplicationMusicPlayer.shared.state.playbackStatus)
//
//  }
//}
//
//extension StationView {
//  private var currentSong: Song? {
//    guard let item =  queue.currentEntry?.item else {return nil}
//    switch item {
//    case .song(let innerSong):
//      station.markAsPlayed(songID: innerSong.id.rawValue)
//      return innerSong
//    default:
//      return nil
//    }
//  }
//}
