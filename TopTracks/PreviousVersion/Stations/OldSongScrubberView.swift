//import SwiftUI
//import MusicKit
//
//struct SongScrubberView {
//  let currentSong: Song
//  @State private var currentTime: TimeInterval = 0
//  @State private var duration: TimeInterval = 5 * 60
////  @Binding private(set) var isPlaying: Bool
//  @State private var isDraggingSlider = false
//}
//
//extension SongScrubberView: View {
//  var body: some View {
//    Slider(value: $currentTime, in: 0...duration){editing in
//      if !editing {
//      ApplicationMusicPlayer.shared.playbackTime = currentTime
//      }
//      isDraggingSlider = editing
//
//    }
//    .padding()
//    .accentColor(.secondary)
//    .padding(.horizontal)
//      .onAppear {
//        Task {
//          try await startUpdatingCurrentTime()
//        }
//      }
//  }
//
//}
//
//extension SongScrubberView {
//
//  func startUpdatingCurrentTime() async throws {
//    while true {
//      try await Task.sleep(nanoseconds: 8_000_000) // about 120 times a second
//      if ApplicationMusicPlayer.shared.state.playbackStatus == .playing && !isDraggingSlider {
//      currentTime = ApplicationMusicPlayer.shared.playbackTime
//      }
//    }
//  }
//}
