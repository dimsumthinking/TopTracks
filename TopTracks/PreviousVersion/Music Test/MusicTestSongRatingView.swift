import SwiftUI

struct MusicTestSongRatingView {
  @Binding var category: RotationCategory
  @Binding var songIsRated: Bool
}

extension MusicTestSongRatingView: View {
  var body: some View {
    List {
      ForEach(selectableCategories) {cat in
        HStack {
          Group {
            cat.symbol
            Text(cat.likeability)
          }
          .foregroundColor(isChecked(cat) ? .green : .primary)
          Spacer()
          Image(systemName: "checkmark")
            .foregroundColor(isChecked(cat) ? .green : .clear)
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

extension MusicTestSongRatingView {
  private func isChecked(_ cat: RotationCategory) -> Bool {
    category == cat && songIsRated == true
  }
}

