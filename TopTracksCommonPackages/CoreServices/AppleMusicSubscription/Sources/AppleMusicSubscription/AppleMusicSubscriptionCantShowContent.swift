import SwiftUI

struct AppleMusicSubscriptionCantShowContent {
}

extension AppleMusicSubscriptionCantShowContent: View {
  var body: some View {
    Text("""
       This app requires an
       Apple Music Subscription
       Individual, Student, or Family Plan
       to create playlists and play music.
       """)
    .multilineTextAlignment(.center)
  }
}

struct AppleMusicSubscriptionCantShowContent_Preview: PreviewProvider {
  
  static var previews: some View {
    AppleMusicSubscriptionCantShowContent()
  }
}