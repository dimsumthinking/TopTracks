import SwiftUI

struct AppleMusicCategoryView {
  let categories: [AppleMusicCategory]
}

extension AppleMusicCategoryView: View {
  var body: some View {
      List(categories) {category in
        NavigationLink {
          AppleMusicPlaylistsInCategoryView(for: category)
        } label: {
          Text(category.description)
        }
      }
    .navigationTitle("Categories")
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
  }
}

struct AppleMusicCategoryView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicCategoryView(categories: appleMusicCategories)
  }
}

