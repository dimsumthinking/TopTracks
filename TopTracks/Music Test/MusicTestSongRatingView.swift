import SwiftUI

struct MusicTestSongRatingView {
  @Binding var category: RotationCategory
  @Binding var songIsRated: Bool
}

extension MusicTestSongRatingView: View {
  var body: some View {
    VStack {
    List {
      ForEach(selectableCategories) {cat in
        HStack {
          cat.symbol
          Text(cat.likeability)
          Spacer()
          if category == cat && songIsRated == true {
            Image(systemName: "checkmark")
              .foregroundColor(.green)
          }
        }
        .contentShape(Rectangle())
        .onTapGesture {
          category = cat
          songIsRated = true
        }
    
      }

    }
    .padding(.horizontal)

    }
  }
}
