import SwiftUI
import MusicKit

struct SongScrubberView {
  let duration: TimeInterval?
  @State private var currentTime: TimeInterval = 0
  @State private var isDraggingSlider = false
}

extension SongScrubberView: View {
  var body: some View {
    if let duration {
      Slider(value: $currentTime,
             in: 0...duration) {
        Text("Song Scrubber")
      } minimumValueLabel: {
        Text(timeInterval(for: currentTime))
          .font(.callout)
      } maximumValueLabel: {
        Text("-" + timeInterval(for: duration - currentTime))
          .font(.callout)
      } onEditingChanged:
             {editing in
        if !editing {
          ApplicationMusicPlayer.shared.playbackTime = currentTime
        }
        isDraggingSlider = editing
      }
      .tint(.secondary)
      .scaleEffect(0.75)
      .onAppear {
        Task {
          try await startUpdatingCurrentTime()
        }
      }
    } else {
      Rectangle()
        .frame(width: .infinity, height: 5)
    }
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
  
  extension SongScrubberView {
    
    func startUpdatingCurrentTime() async throws {
      while true {
        try await Task.sleep(for: .seconds(0.5))
        if ApplicationMusicPlayer.shared.state.playbackStatus == .playing && !isDraggingSlider {
          currentTime = ApplicationMusicPlayer.shared.playbackTime
        }
      }
    }
  }
