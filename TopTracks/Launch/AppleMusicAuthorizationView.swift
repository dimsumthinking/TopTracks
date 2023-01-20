import SwiftUI
import MusicKit
import AppleMusicAuthorization

struct AppleMusicAuthorizationView {
  @Binding var musicAuthorizationStatus: MusicAuthorization.Status
}

extension AppleMusicAuthorizationView: View {
  var body: some View {
    VStack {
      AuthorizationView(status: $musicAuthorizationStatus)
      if musicAuthorizationStatus == .denied {
        Button("Go to Settings") {
          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        .padding(.top)
      }
    }
  }
}

struct AppleMusicAuthorizationView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicAuthorizationView(musicAuthorizationStatus: .constant(.notDetermined))
  }
}
