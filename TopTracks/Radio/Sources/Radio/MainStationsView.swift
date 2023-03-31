import SwiftUI
import ApplicationState
import AudioToolbox
import MusicKit
import Constants

public struct MainStationsView {
  @State private var isShowingFullPlayer = false
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  public init() {
    
  }
}

extension MainStationsView: View {
  public var body: some View {
//    VStack {
//    if isShowingFullPlayer {
//      FullPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
//        .transition(.scale(scale: 0.05,
//                           anchor: Constants.anchorPointForPlayerTransition))
//    } else {
//      NavigationStack {
        ZStack {
//          VStack {
            NavigationStack {
              StationListView()
                .navigationTitle("Stations")
                .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                      ApplicationState.shared.beginCreating()
                    } label: {
                      Image(systemName: "plus")
                    }
                  }
                  ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                  }
                }
            }
//          }
//          VStack {
          if isShowingFullPlayer {
            FullPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
              .transition(.scale(scale: 0.05,
                                 anchor: Constants.anchorPointForPlayerTransition))
          } else {
          VStack {
            Spacer()
            MiniPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
//              .onTapGesture {
//                isShowingFullPlayer = true
//              }
          }
        }
//      }
      //
      //      .sheet(isPresented: $isShowingFullPlayer) {
      //        FullPlayerView()
      //      }
    }

//    }
    .animation(.easeInOut, value: isShowingFullPlayer)
    .onChange(of: queue.currentEntry) { entry in
      if let entry {
        ApplicationState.shared.setCurrentSong(using: entry)
      }
    }
  }
}


//import SwiftUI
//import ApplicationState
//import AudioToolbox
//import MusicKit
//import Constants
//
//public struct MainStationsView {
//  @State private var isShowingFullPlayer = false
//  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
//  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
//  public init() {
//
//  }
//}
//
//extension MainStationsView: View {
//  public var body: some View {
//    VStack {
//    if isShowingFullPlayer {
//      FullPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
//        .transition(.scale(scale: 0.05,
//                           anchor: Constants.anchorPointForPlayerTransition))
//    } else {
//      NavigationStack {
//        ZStack {
//          VStack {
//            StationListView()
//              .navigationTitle("Stations")
//              .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                  Button {
//                    ApplicationState.shared.beginCreating()
//                  } label: {
//                    Image(systemName: "plus")
//                  }
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                  EditButton()
//                }
//              }
//          }
//          VStack {
//            Spacer()
//            MiniPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
////              .onTapGesture {
////                isShowingFullPlayer = true
////              }
//          }
//        }
//      }
//      //
//      //      .sheet(isPresented: $isShowingFullPlayer) {
//      //        FullPlayerView()
//      //      }
//    }
//
//    }
//    .animation(.easeInOut, value: isShowingFullPlayer)
//    .onChange(of: queue.currentEntry) { entry in
//      if let entry {
//        ApplicationState.shared.setCurrentSong(using: entry)
//      }
//    }
//  }
//}
