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
  
  
