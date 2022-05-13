import SwiftUI
import MusicKit

struct FullPlayer {
  let currentSong: Song?
  @ObservedObject private(set) var playerState = ApplicationMusicPlayer.shared.state
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  @Environment(\.openURL) private var openURL
  let retrievedArtwork: Artwork?
  @Binding var imageName: String?
  @Binding var isShowingFullPlayer: Bool
  @State private var isShowingShareSheet = false
}

extension FullPlayer: View {
  var body: some View {
    VStack {
      if topTracksStatus.isNotConnected {
        OfflineWarningView()
      }
      VStack {
        if let stationName = currentlyPlaying.station?.stationName {
          Text(stationName)
            .padding()
        }
        
        if let currentSong = currentSong {
          ZStack {
          PlayerArtwork(song: currentSong,
                        size: fullArtworkImageSize,
                        retrievedArtwork: retrievedArtwork)
            if let stationType = currentlyPlaying.station?.stationType,
               let imageName = imageName,
               stationType == .playlist {
              ZStack {
                Circle()
                  .frame(width: backButtonArtworkImageSize , height: backButtonArtworkImageSize)
                  .foregroundColor(.blue.opacity(0.8))
                Image(systemName: imageName)
              }
              .contentShape(Rectangle())
              .onTapGesture {
                incrementImageName()
                
//                adjustFrequencyChange(.theSame)
              }
                     .padding()
              .offset(x: fullArtworkImageSize/2, y: -fullArtworkImageSize/2)
              .padding()
            }
          }
        
          Text(currentSong.title)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .font(.title2)
          Text(currentSong.artistName)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
        }
      }
      .contentShape(Rectangle())
      .onTapGesture {
        isShowingFullPlayer = false
      }
      .gesture(DragGesture().onChanged { drag in
        if drag.location.y - drag.startLocation.y > fullPlayerSwipe {
          isShowingFullPlayer = false
        } //else if drag.location.x - drag.startLocation.x > fullPlayerSwipe {
//          adjustFrequencyChange(.moreOften)
//        } else if drag.location.x - drag.startLocation.x < -fullPlayerSwipe {
//          adjustFrequencyChange(.lessOften)
//        }
      }
      )
      if let currentSong = currentSong {
        Spacer()
        HStack(alignment: .top) {
        SongScrubberView(currentSong: currentSong)
          if let currentStation = currentlyPlaying.station,
             currentStation.canBeShared {
            Button(action: {
              isShowingShareSheet = true
            }) {
              Image(systemName: "square.and.arrow.up")
                .font(.title)
            }
          }
        }
      }
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
          Task{
            try await stationSongPlayer.skipToPreviousEntry()
          }}){
            Image(systemName: "backward.fill")
          }
        Spacer()
        switch(playerState.playbackStatus) {
        case .playing:
          Button {
            stationSongPlayer.pause(currentlyPlaying.station,
                                    at: currentlyPlaying.song)
            
          } label: {
            Image(systemName: "pause.fill")
              .font(.largeTitle)
              .padding()
          }
        default:
          Button {
            Task {
              try await stationSongPlayer.restart()
            }
          } label: {
            Image(systemName: "play.fill")
              .font(.largeTitle)
              .padding()
          }
        }
        Spacer()
        Button(action: {
          Task {
          try await stationSongPlayer.skipToNextEntry()
        }}){
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
//      Button("Open in Apple Music") {
//        Task {
//          await openInAppleMusic()
//        }
//      }
    }
    .sheet(isPresented: $isShowingShareSheet) {
      if let song = currentSong,
         let station = currentlyPlaying.station {
        TopTracksShareSheet(song: song, station: station)
      } 
    }
  }
}


extension FullPlayer {
  private func appleMusicURL() async -> URL? {
    var components = URLComponents()
    guard let store = (try? await MusicDataRequest.currentCountryCode),
          let songID = currentSong?.id.rawValue else {return nil}
    components.scheme = "music"
    components.host = "music.apple.com"
    components.path = "/\(store)/song/\(songID)"
    components.queryItems = [URLQueryItem(name: "app", value: "itunes")]
    return components.url
  }
  
  private func openInAppleMusic() async {
    if let url = await appleMusicURL() {
      openURL(url)
    }
  }
  private func adjustFrequencyChange(increase: Bool) {
    guard let song = currentlyPlaying.topTracksSong,
          let delta = UpdateFrequencyChange(rawValue: Int(song.upOrDown)) else {return}
    if increase {
      song.adjustFrequencyChange(delta.increase)
    } else {
      song.adjustFrequencyChange(delta.decrease)
    }
    frequencyChangeImageName()
  }
  
  private func adjustFrequencyChange(_ delta: UpdateFrequencyChange) {
    guard let song = currentlyPlaying.topTracksSong else {return}
    song.adjustFrequencyChange(delta)
    frequencyChangeImageName()
  }
  
  private func frequencyChangeImageName() {
    guard let upOrDown = currentlyPlaying.topTracksSong?.upOrDown else {return}
    imageName = UpdateFrequencyChange(rawValue: Int(upOrDown))?.imageName ?? "heart"
  }
  private func incrementImageName() {
    if imageName == UpdateFrequencyChange.theSame.imageName {
      adjustFrequencyChange(.moreOften)
    } else if imageName == UpdateFrequencyChange.moreOften.imageName {
      adjustFrequencyChange(.lessOften)
    } else {
      adjustFrequencyChange(.theSame)
    }
  }
}


