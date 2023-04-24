import SwiftUI
import ApplicationState

public struct MainCreationView {
  public init() {
    
  }
}

extension MainCreationView: View {
  public var body: some View {
    NavigationStack {
      VStack {
       HeaderView(title: "New Station Categories")
        PlaylistKindView()
      }
    }
  }
}
