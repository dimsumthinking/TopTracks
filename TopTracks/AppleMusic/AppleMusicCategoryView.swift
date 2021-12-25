import SwiftUI

struct AppleMusicCategoryView {
}

extension AppleMusicCategoryView: View {
  var body: some View {
    List {
      ForEach(appleMusicCategories) {category in
        NavigationLink {
          AppleMusicPlaylistsInCategoryView(for: category)
            .navigationTitle(category.description)
        } label: {
          Text(category.description)
        }
      }
    }
    .modifier(InfoModifier(message: "To create a station,\n first Choose a category"))
  }
}

struct AppleMusicCategoryView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicCategoryView()
  }
}

