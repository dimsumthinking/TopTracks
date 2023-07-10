import MusicKit
import SwiftUI

public struct  AuthorizationView {
  @Binding public var status: MusicAuthorization.Status
  
//  public init(status: Binding<MusicAuthorization.Status>) {
//    self._status = status
//  }
}

extension AuthorizationView: View {
  public var body: some View {
    Text(string)
      .multilineTextAlignment(.center)
      .task {
        status = await MusicAuthorization.request()
      }
  }
}

extension AuthorizationView {
  private var string: String {
    switch status {
    case .notDetermined:
      return "Checking Music Authorization"
    case .denied:
      return """
      TopTracks requires access
      to Apple Music.
      """
      case .restricted:
      return """
      Restricted:
      You are not able
      to authorize access
      to your music library
      on this device.
      """
    case .authorized:
      return "Music access is authorized"
    @unknown default:
      return "Music Authorization Status can't be determined"
    }
  }
}

//#Preview {
//  AuthorizationView(status: .constant(.denied))
//}

