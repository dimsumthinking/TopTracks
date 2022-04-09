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
                           categories: standardRotationCategories)
        Button("Next", action: {showNext = true})
          .buttonStyle(.borderedProminent)
          .padding()
        NavigationLink(isActive: $showNext) {
          AppleMusicCategoryChooserView()
        } label: {
          EmptyView()
        }
        
      }
    }
    .navigationTitle("The Rotation Clock")
    .navigationBarTitleDisplayMode(.inline)
    .modifier(MusicTestCancellation())
  }
  }
}

struct StationCreationOverview_Previews: PreviewProvider {
  static var previews: some View {
    StationCreationOverview()
  }
}