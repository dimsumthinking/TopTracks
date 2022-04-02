import SwiftUI
import MusicKit

struct AppleMusicAuthorizationView {
  @Binding var authorization: MusicAuthorization.Status
}

extension AppleMusicAuthorizationView: View {
  var body: some View {
    Text("Checking Authorization")
      .task {
        authorization = await MusicAuthorization.request()
      }
  }
}
