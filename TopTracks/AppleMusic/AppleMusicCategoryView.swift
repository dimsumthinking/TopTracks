import SwiftUI

struct AppleMusicCategoryView {
}

extension AppleMusicCategoryView: View {
  var body: some View {
    VStack {
      InstructionView("Choose a category for your station.")
      List {
        ForEach(appleMusicCategories) {category in
          NavigationLink {
            AppleMusicPlaylistsInCategoryView(for: category)
          } label: {
            Text(category.description)
          }
        }
      }
    }
    .modifier(StationBuildCancellation())
  }
}

struct AppleMusicCategoryView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicCategoryView()
  }
}

