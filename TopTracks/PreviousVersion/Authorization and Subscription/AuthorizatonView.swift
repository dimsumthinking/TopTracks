import SwiftUI
import MusicKit

struct AuthorizationView {
  @Binding var authorization: MusicAuthorization.Status
}

extension AuthorizationView: View {
  var body: some View {
    Text("Checking Authorization")
      .task {
        authorization = await MusicAuthorization.request()
      }
  }
}
