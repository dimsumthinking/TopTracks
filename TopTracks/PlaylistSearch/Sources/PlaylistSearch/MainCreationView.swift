import SwiftUI
import ApplicationState

public struct MainCreationView: View {
  public init() {
    
  }
}

extension MainCreationView {
  public var body: some View {
    NavigationStack {
      PlaylistKindView()
        .navigationTitle("Kinds of Playlists")
      #if !os(macOS)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              CurrentActivity.shared.endCreating()
            }
          }
        }
      #endif
    }
  }
}
