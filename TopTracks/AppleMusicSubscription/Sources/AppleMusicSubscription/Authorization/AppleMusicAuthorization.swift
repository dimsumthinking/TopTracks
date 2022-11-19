import MusicKit
import SwiftUI

public class AppleMusicAuthorization: ObservableObject {
  public private(set) var status: MusicAuthorization.Status = .notDetermined
  
  public init() {
    Task {
      status = await MusicAuthorization.request()
    }
  }
 
  public var view: some View {
    VStack {
      Text(string)
      if status == .denied {
        Button("Go to Settings") {
          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        .padding(.top)
      }
    }
  }
}

extension AppleMusicAuthorization {
  private var string: String {
    switch status {
    case .notDetermined:
      return "Checking Music Authorization"
    case .denied:
      return "This app requires access to Apple Music."
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
