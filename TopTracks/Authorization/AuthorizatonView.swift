import SwiftUI
import MusicKit

struct AuthorizationView {
  @Binding var authorization: MusicAuthorization.Status
//  @Binding var subscription: MusicSubscription?
}

extension AuthorizationView: View {
  var body: some View {
    Text("Checking Authorization")
      .task {
        authorization = await MusicAuthorization.request()
//        for await subscription in MusicSubscription.subscriptionUpdates {
//          self.subscription = subscription
//        }
      }
  }
}
