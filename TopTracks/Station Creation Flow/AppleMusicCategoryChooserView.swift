import SwiftUI

struct AppleMusicCategoryChooserView {
  let categories: [AppleMusicCategory]
}

extension AppleMusicCategoryChooserView: View {
  var body: some View {
      List(categories) {category in
        NavigationLink {
          AppleMusicPlaylistsInCategoryChooserView(for: category)
        } label: {
          Text(category.description)
        }
      }
    .navigationTitle("Categories")
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
  }
}

struct AppleMusicCategoryChooserView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicCategoryChooserView(categories: appleMusicCategories)
  }
}

