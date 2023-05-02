import SwiftUI
import ApplicationState

struct InfoView {
  @Binding var isShowingInfo: Bool
  @Environment(\.colorScheme) private var colorScheme
}

extension InfoView: View {
  var body: some View {
    VStack {
        Text("About")
        .font(.title)
        TabView {
         AddAPlaylist()
            .tabItem {
              Text("Add a playlist")
            }
          ClockInfo()
            .tabItem {
              Text("Play a station")
            }
          WorkWithStations()
            .tabItem {
              Text("Station actions")
            }
          PlayAStation()
            .tabItem {
              Text("The player")
            }
//          RatingInfo()

        }
//        .tabViewStyle(.page)
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
//      .toolbar {
//        ToolbarItem(placement: .navigationBarTrailing) {
//          Button {
//            isShowingInfo = false
//          } label: {
//            Text("Done")
//          }
//        }
//      }
          .preferredColorScheme(colorScheme)

    }
  }
}
