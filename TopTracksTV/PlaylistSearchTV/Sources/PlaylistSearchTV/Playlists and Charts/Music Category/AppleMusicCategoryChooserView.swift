import SwiftUI
import ApplicationState
import PlaylistSearchShared

struct AppleMusicCategoryChooserView: View {
  let categories: [AppleMusicCategory]
//  @State private var filterString = ""
  private let playlistKind: PlaylistKind
  
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  
  init(categories: [AppleMusicCategory],
       playlistKind: PlaylistKind) {
    self.categories = categories
    self.playlistKind = playlistKind
  }
}

extension AppleMusicCategoryChooserView {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(categories) {category in
          NavigationLink(value: category) {
            Button {
              
            } label: {
              HStack {
                Spacer()
                Text(category.description)
                Spacer()
              } 
            }
          }
        }
      }
    }
//    .searchable(text: $filterString)
    .navigationDestination(for: AppleMusicCategory.self) { category in
      PlaylistChooserView(category: category)
//        .navigationTitle(category.description)
    }
  }
}

//extension AppleMusicCategoryChooserView {
//  var filteredCategories: [AppleMusicCategory] {
//    guard !filterString.isEmpty else {return categories}
//    return categories.filter{$0.description.lowercased().contains(filterString.lowercased())}
//    
//  }
//}

struct AppleMusicCategoryChooserView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicCategoryChooserView(categories: AppleMusicCategory.appleMusicDecades,
                                  playlistKind: .moodAndActivity)
  }
}

