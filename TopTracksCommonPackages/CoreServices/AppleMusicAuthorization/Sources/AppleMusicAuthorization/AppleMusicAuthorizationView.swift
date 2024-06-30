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
      #if !os(macOS)
      if musicAuthorizationStatus == .denied {
        Button("Go to Settings") {
          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        .padding(.top)
      }
#endif

    }
  }
}

//#Preview {
//  @Previewable
//  @State var musicAutorizationStatus: MusicAuthorization.Status = .denied
//  AppleMusicAuthorizationView(musicAuthorizationStatus: $musicAutorizationStatus)
//}

