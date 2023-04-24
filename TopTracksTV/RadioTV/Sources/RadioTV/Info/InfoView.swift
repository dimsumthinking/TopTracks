import SwiftUI
import ApplicationState

struct InfoView {
  @Binding var isShowingInfo: Bool
  @Environment(\.colorScheme) private var colorScheme
}

extension InfoView: View {
  var body: some View {
    NavigationStack {
        TabView {
         AddAPlaylist()
          ClockInfo()
          PlayAStation()
          RatingInfo()
          WorkWithStations()
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            isShowingInfo = false
          } label: {
            Text("Done")
          }
        }
      }
          .preferredColorScheme(colorScheme)

    }
  }
}
