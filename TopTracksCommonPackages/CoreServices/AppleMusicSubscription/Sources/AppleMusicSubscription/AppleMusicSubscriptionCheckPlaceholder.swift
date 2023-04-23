import SwiftUI

struct AppleMusicSubscriptionIsChecking {
  
}

extension AppleMusicSubscriptionIsChecking: View {
  var body: some View {
    VStack {
      Text("Checking Apple Music Subscription")
      ProgressView()
    }
  }
}

struct AppleMusicSubscriptionIsChecking_Preview: PreviewProvider {
  
  static var previews: some View {
    AppleMusicSubscriptionIsChecking()
  }
}
