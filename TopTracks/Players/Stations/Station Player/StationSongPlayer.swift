import MusicKit
import AudioToolbox

let stationSongPlayer = StationSongPlayer()

class StationSongPlayer {
  private var player = ApplicationMusicPlayer.shared
  private var currentPlaybackTime: TimeInterval = 0
  fileprivate init(){}
}

extension StationSongPlayer {
  
  func pause(_ station: TopTracksStation? = nil,
             at song: Song? = nil) {
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
      print(station.stationName, station.stationType)
      if station.stationType == .station {
        try await queue(for: station)
      } else {
      ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: songs)
      }
      try await player.prepareToPlay()
      try await player.play()
    }
  
  private func queue(for station: TopTracksStation) async throws {
    if let stationID = station.appleStationInfo?.appleStationID {
    let musicID = MusicItemID(stationID)
    let request = MusicCatalogResourceRequest<Station>(matching: \.id,
                                                         equalTo: musicID)
      print("loading queue for ", station.stationName)
    let response = try await request.response()
    guard let stationData = response.items.first else { return }
    ApplicationMusicPlayer.shared.queue = [stationData]
    }
  }
    
    func restart() async throws {
      try await player.play()
    }
    
    func clearPlayer() {
      ApplicationMusicPlayer.shared.queue = ApplicationMusicPlayer.Queue(for: [Song]())
      ApplicationMusicPlayer.shared.queue.currentEntry = nil
    }
    func skipToNextEntry() async throws {
      try await player.skipToNextEntry()
    }
    func skipToPreviousEntry() async throws {
      if player.playbackTime < 3 {
      try await player.skipToPreviousEntry()
      } else {
        player.restartCurrentEntry()
      }
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


