import SwiftUI
import ApplicationState

public struct MainCreationView: View {
  public init() {
    
  }
}

extension MainCreationView {
  public var body: some View {
    NavigationStack {
      VStack {
       HeaderView(title: "New Station Categories")
        PlaylistKindView()
      }
      .onExitCommand {
        CurrentActivity.shared.endCreating()
      }
    }
  }
}
