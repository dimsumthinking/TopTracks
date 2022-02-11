import SwiftUI
import MusicKit

struct StationView {
  let station: TopTracksStation
  @State var isRefreshed = false
  @ObservedObject var queue = ApplicationMusicPlayer.shared.queue
  let player = ApplicationMusicPlayer.shared
  @State var isPlaying = false
}

extension StationView: View {
  var body: some View {
    VStack {
      if let artwork = queue.currentEntry?.artwork {
        ArtworkImage(artwork,
                     width: UIScreen.main.bounds.width,
                     height: UIScreen.main.bounds.width)
          .border(Color.primary.opacity(0.3))
          .padding()
      }
      Spacer()
      Group {
      Text(currentSong?.title ?? "")
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)
        .font(.title)
      Text(currentSong?.artistName ?? "")
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)
      }
      Spacer()
      HStack {
        Spacer()
        Button(action: {Task{try await player.skipToPreviousEntry()}}){
          Image(systemName: "backward.fill")
        }
        Spacer()
        Button(action: {Task{try await playOrPause()}}){
          Image(systemName: isPlaying ? "pause.fill" : "play.fill")
        }
        Spacer()
        Button(action: {Task{try await player.skipToNextEntry()}}){
          Image(systemName: "forward.fill")
        }
        Spacer()
      }
      .font(.largeTitle)
      .foregroundColor(.primary)
Spacer()
    }
    .onAppear {
      ApplicationMusicPlayer.shared.queue = musicQueue(for: station)
      Task {try await ApplicationMusicPlayer.shared.prepareToPlay()
        try await player.play()
        isPlaying = true
      }
    }
    .navigationTitle(station.stationName)
}
}


@MainActor
extension StationView {
  private func playOrPause() async throws {
    if isPlaying {
      player.pause()
      isPlaying = false
    } else {
      try await player.play()
      isPlaying = true
    }
  }
}

extension StationView {
  private var currentSong: Song? {
    guard let item =  queue.currentEntry?.item else {return nil}
    switch item {
    case .song(let innerSong):
      return innerSong
    default:
      return nil
    }
  }
}

//extension StationView {
//  func getSongs() -> [Song] {
//     var songs = station.stacks.flatMap(\.songs).compactMap(\.song)
//    songs.append(songs[2])
//    return songs
//  }
//}

//extension StationView {
//  func getSongs() -> [TopTracksSong] {
//    var songs = station.stacks.flatMap(\.songs)//.compactMap(\.song)
//    songs.append(songs[2])
//    return songs
//  }
//}

//struct StationView_Previews: PreviewProvider {
//    static var previews: some View {
//        StationView()
//    }
//}
