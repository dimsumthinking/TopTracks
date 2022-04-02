import SwiftUI
import MusicKit

struct ReconsiderAppleMusicAuthorizationView: View {
    @Binding private(set) var authorization: MusicAuthorization.Status
    
  var body: some View {
    VStack(spacing: 40) {
      Text("This app requires access to Apple Music.")
      Button(action: requestAuthorization){
        Text("Go to Settings")
      }
    }
  }
    
    private func requestAuthorization() {
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
}

