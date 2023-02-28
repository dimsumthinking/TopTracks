import SwiftUI

struct AppleMusicCategoryChooserView {
  let categories: [AppleMusicCategory]
  @State private var filterString = ""
  
  init(categories: [AppleMusicCategory]) {
    self.categories = categories
  }
}

extension AppleMusicCategoryChooserView: View {
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
    .navigationTitle("Categories")
    .navigationBarTitleDisplayMode(.inline)
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
    AppleMusicCategoryChooserView(categories: AppleMusicCategory.appleMusicDecades)
  }
}

