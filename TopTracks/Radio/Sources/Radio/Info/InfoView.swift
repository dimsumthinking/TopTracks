import SwiftUI

struct InfoView: View {
  @Binding var mainStationsSheet: MainStationsSheet?
  @Environment(\.colorScheme) private var colorScheme
}

extension InfoView {
  var body: some View {
    NavigationStack {
        TabView {
         AddAPlaylist()
          ClockInfo()
          PlayAStation()
          MusicPlayers()
          RatingInfo()
          WorkWithStations()
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            mainStationsSheet = nil
          } label: {
            Text("Done")
          }
        }
      }
          .preferredColorScheme(colorScheme)

    }
  }
}
