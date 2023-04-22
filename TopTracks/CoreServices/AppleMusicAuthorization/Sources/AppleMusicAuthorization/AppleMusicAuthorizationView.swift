import SwiftUI
import MusicKit

public struct AppleMusicAuthorizationView {
  @Binding var musicAuthorizationStatus: MusicAuthorization.Status
  public init(musicAuthorizationStatus: Binding<MusicAuthorization.Status>) {
    self._musicAuthorizationStatus = musicAuthorizationStatus
  }
}

extension AppleMusicAuthorizationView: View {
  public var body: some View {
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

//struct AppleMusicAuthorizationView_Preview: PreviewProvider {
//  
//  static var previews: some View {
//    AppleMusicAuthorizationView(musicAuthorizationStatus: .constant(.denied))
//  }
//}
