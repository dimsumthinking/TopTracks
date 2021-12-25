import SwiftUI

struct AppleMusicCategoryView {
}

extension AppleMusicCategoryView: View {
  var body: some View {
    List {
      ForEach(appleMusicCategories) {category in
        NavigationLink {
          StationBuilderStage("Next Choose a Playlist. Every station begins from a playlist.") {
          AppleMusicPlaylistsInCategoryView(for: category)
          }
            .navigationTitle(category.description)
        } label: {
          Text(category.description)
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

