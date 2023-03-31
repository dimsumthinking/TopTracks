
import SwiftUI
import MusicKit
import PlaylistSearch
import ApplicationState
import Radio
import StationUpdaters

struct MainView: View {
  //  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  //  @ObservedObject private var applicationState = ApplicationState.shared
  @State private var isCreating = false
  @EnvironmentObject private var applicationState: ApplicationState
  
  
  var body: some View {
    Group {
      switch applicationState.currentActivity {
      case .enjoying: MainStationsView()
      case .creating:  MainCreationView()
      case .viewingOrEditing(let station): MainStationSongListView(station)
      case .importing(let url):  Text("Not implemented yet for" + (url?.description ?? "no url"))
      }
    }
    
  }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}




//
//import SwiftUI
//import MusicKit
//import PlaylistSearch
//import ApplicationState
//import Radio
//
//struct MainView: View {
////  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
////  @ObservedObject private var applicationState = ApplicationState.shared
//  @EnvironmentObject private var applicationState: ApplicationState
//
//
//    var body: some View {
//      NavigationStack {
//        switch applicationState.currentActivity {
//        case .playing:
//          StationListView()
//            .toolbar {
//              ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                  applicationState.beginCreating()
//                } label: {
//                  Image(systemName: "plus")
//                }
//              }
//              ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//
//                } label: {
//                  Image(systemName: "gear")
//                }
//              }
//            }
//            .navigationTitle("Top Tracks Stations")
//            .navigationBarTitleDisplayMode(.inline)
//        case .creating:
//          PlaylistSearchDirectoryView()
//            .toolbar {
//              ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Cancel") {
//                  ApplicationState.shared.endCreating()
//                }
//              }
//            }
//
//        case .importing(let url):
//          Text("Importing \(url?.description ?? "no url")")
//        }
//
//      }
//
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
//
