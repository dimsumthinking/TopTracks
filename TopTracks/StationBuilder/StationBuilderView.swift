import SwiftUI

struct StationBuilderView {
}

extension StationBuilderView: View {
  var body: some View {
    NavigationView {
      AppleMusicCategoryView(categories: appleMusicCategories)
//        .navigationTitle("Categories")
//        .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct StationBuilderView_Previews: PreviewProvider {
  static var previews: some View {
    StationBuilderView()
  }
}
