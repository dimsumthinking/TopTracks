import SwiftUI

struct StationBuilderView {
}

extension StationBuilderView: View {
  var body: some View {
    NavigationView {
      AppleMusicCategoryView()
        .navigationTitle("Station Builder")
    }
  }
}

struct StationBuilderView_Previews: PreviewProvider {
  static var previews: some View {
    StationBuilderView()
  }
}
