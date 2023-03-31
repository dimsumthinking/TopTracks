import SwiftUI
import MusicKit

struct SongScrubberView {
  let currentSong: Song
  @State private var currentTime: TimeInterval = 0
//  @State private var duration: TimeInterval = 5 * 60
//  @Binding private(set) var isPlaying: Bool
  @State private var isDraggingSlider = false
}

extension SongScrubberView: View {
  var body: some View {
    VStack {

      if let duration = currentSong.duration {
      HStack {
        Text(timeInterval(for: currentTime))
        Spacer()
        Text(timeInterval(for: duration - currentTime))
      }
      .padding(.horizontal)
      .font(.caption)
      .padding(.horizontal)
    }
    Slider(value: $currentTime, in: 0...(currentSong.duration ?? 5 * 60)){editing in
      if !editing {
      ApplicationMusicPlayer.shared.playbackTime = currentTime
      }
      isDraggingSlider = editing

    }
    .padding(.horizontal)
    .accentColor(.secondary)
    .padding(.horizontal)
      .onAppear {
        Task {
          try await startUpdatingCurrentTime()
        }
      }
      if let duration = currentSong.duration {
        
        HStack {
          Button {
            ApplicationMusicPlayer.shared.playbackTime = max(0, ApplicationMusicPlayer.shared.playbackTime - 15)
          } label: {
            Image(systemName: "gobackward.15")
          }
          Spacer()
          Button {
            ApplicationMusicPlayer.shared.playbackTime = min(duration, ApplicationMusicPlayer.shared.playbackTime + 30)
          } label: {
            Image(systemName: "goforward.30")
          }
        }
        .padding(.horizontal)
        .font(.title)
        .padding()
      }
    }
    .padding(.vertical)
  }
}

import Foundation

fileprivate let formatter = DateComponentsFormatter()
extension SongScrubberView {
  private func timeInterval(for seconds: Double) -> String {
    formatter.allowedUnits = [.minute, .second]
    formatter.zeroFormattingBehavior = .pad
    guard var formattedTime = formatter.string(from: seconds) else {return "-:--"}
    if formattedTime.first == "0" {
      formattedTime = String(formattedTime.dropFirst())
    }
    return formattedTime
  }
}
import AVFAudio
extension SongScrubberView {

  func startUpdatingCurrentTime() async throws {
    while true {
      try await Task.sleep(nanoseconds: 8_000_000) // about 120 times a second
      if ApplicationMusicPlayer.shared.state.playbackStatus == .playing && !isDraggingSlider {
      currentTime = ApplicationMusicPlayer.shared.playbackTime
      }
    }
  }
}
