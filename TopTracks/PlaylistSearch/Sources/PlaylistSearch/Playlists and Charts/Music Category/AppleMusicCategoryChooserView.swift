import SwiftUI
import ApplicationState
import PlaylistSearchShared

struct AppleMusicCategoryChooserView: View {
  let categories: [AppleMusicCategory]
  @State private var filterString = ""
  private let playlistKind: PlaylistKind
  
  init(categories: [AppleMusicCategory],
       playlistKind: PlaylistKind) {
    self.categories = categories
    self.playlistKind = playlistKind
  }
}

extension AppleMusicCategoryChooserView {
  var body: some View {
      List(filteredCategories) {category in
        NavigationLink {
         PlaylistChooserView(category: category)
            .navigationTitle(category.description)
        } label: {
          Text(category.description)
        }
      }
      .searchable(text: $filterString)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Cancel") {
            CurrentActivity.shared.endCreating()
          }
        }
      }
  }
}

extension AppleMusicCategoryChooserView {
  var filteredCategories: [AppleMusicCategory] {
    guard !filterString.isEmpty else {return categories}
    return categories.filter{$0.description.lowercased().contains(filterString.lowercased())}
    
  }
}

struct AppleMusicCategoryChooserView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicCategoryChooserView(categories: AppleMusicCategory.appleMusicDecades,
                                  playlistKind: .moodAndActivity)
  }
}

