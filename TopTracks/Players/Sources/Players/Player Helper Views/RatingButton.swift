import SwiftUI
import Model


struct RatingButton: View {
  let rating: SongRating
  @Binding var isShowingAlert: Bool
  let action: (SongRating) -> Void
}

extension RatingButton {
  var body: some View {
    Button (role: rating == .remove ? .destructive : .none) {
      if rating == .remove {
        isShowingAlert = true
      } else {
        action(rating)
      }
    } label: {
      HStack {
        Image(systemName: rating.icon)
        Text(rating.name)
      }
    }
  }
}


