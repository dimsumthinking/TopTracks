import MusicKit
import AudioToolbox

let stationSongPlayer = StationSongPlayer()

class StationSongPlayer {
  private var player = ApplicationMusicPlayer.shared
  fileprivate init(){}
}

extension StationSongPlayer {
  
  func pause() {
    player.pause()
  }
  
  var state: ApplicationMusicPlayer.State {
    ApplicationMusicPlayer.shared.state
  }
  func prepareToPlay() {
    Task {
     try await player.prepareToPlay()
    }
  }

  func play(_ station: TopTracksStation) async throws {
      let songs = stationSongQueue.fillQueue(for: station)
      ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: songs)
      try await player.prepareToPlay()
      try await player.play()
  }
  

  func restartCurrentEntry() {
    
  }
  func skipToNextEntry() {
    
  }
  func skiptoPreviousEntry() {
    
  }
  var isPlaying: Bool {
    player.state.playbackStatus == .playing
  }
  
}

//struct StationView {
//  let station: TopTracksStation
//  @State var isRefreshed = false
//  @ObservedObject var queue = ApplicationMusicPlayer.shared.queue
//  let player = ApplicationMusicPlayer.shared
//  @ObservedObject var state = ApplicationMusicPlayer.shared.state
//  private(set) static var currentStationID =  UUID()
//}
//
//extension StationView: View {
//  var body: some View {
//    VStack {
//      Text(station.stationName)
//        .font(.headline)
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
//        SongScrubberView(currentSong: currentSong)
//      }
//
//      HStack {
//        Spacer()
//        Button(action: {Task{try await player.skipToPreviousEntry()}}){
//          Image(systemName: "backward.fill")
//        }
//        Spacer()
//        Button(action: {Task{try await playOrPause()}}){
//          Image(systemName: state.playbackStatus == .playing ? "pause.fill" : "play.fill")
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
//          try await player.play()
//        }
//      }
//      StationView.currentStationID = station.stationID
//    }
////    .navigationTitle(station.stationName)
//  }
//}
//
//
//@MainActor
//extension StationView {
//  private func playOrPause() async throws {
//    switch state.playbackStatus {
//    case .playing:
//      player.pause()
//    case .paused:
//      try await player.play()
//    default:
//      print("Should be unreachable")
//    }
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
//
//
//
//extension StationSongPlayer {
//  fileprivate func fillSongList() {
//    for index in 0...numberOfSongsInMusicQueue {
//      let currentCategory = clock.slots[index % clock.numberOfSlots]
//      if let song = nextSong(in: currentCategory) {
//        songList.append(song)
//      }
//    }
//  }
//
//  private func nextSong(in category: RotationCategory) -> Song? {
//    guard var stack = stacks[category],
//          stack.count > 2 else {return nil}
//    let index = Int.random(in: 0...1)
//    let song = stack.remove(at: index)
//    stacks[category] = stack + [song]
//    return song
//  }
//}
//
