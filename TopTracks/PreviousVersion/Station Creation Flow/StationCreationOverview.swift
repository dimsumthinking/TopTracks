import SwiftUI

struct StationCreationOverview {
  @State private var showNext = false
}

extension StationCreationOverview: View {
  var body: some View {
    NavigationView {
    ScrollView {
      VStack {
        Text("The songs you choose from an Apple Music Playlist will rotate using this clock.")
          .multilineTextAlignment(.center)
          .padding()
        ClockAndLegendView(clock: .hourWithSpice,
                           categories: expandedCategories)
        Button("Next", action: {showNext = true})
          .buttonStyle(.borderedProminent)
          .padding()
        NavigationLink(isActive: $showNext) {
          AppleMusicCategoryChooserView(categories: appleMusicCategories
          )
        } label: {
          EmptyView()
        }
        
      }
    }
    .navigationTitle("The Rotation Clock")
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
  }
  }
}

struct StationCreationOverview_Previews: PreviewProvider {
  static var previews: some View {
    StationCreationOverview()
  }
}
