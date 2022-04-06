import SwiftUI

struct MusicTestSongRatingView {
  @Binding var category: RotationCategory
  var next: () -> Void
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
          Task {
            if category != .notIncluded {
              try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
            next()
          }
        }
      }
    }
    .padding(.horizontal)
  }
}

extension MusicTestSongRatingView {
  private func isChecked(_ cat: RotationCategory) -> Bool {
    category == cat  && cat != .notRated
  }
}

