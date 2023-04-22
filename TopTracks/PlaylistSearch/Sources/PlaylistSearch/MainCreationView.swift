import SwiftUI
import ApplicationState

public struct MainCreationView {
  public init() {
    
  }
}

extension MainCreationView: View {
  public var body: some View {
    NavigationStack {
      PlaylistKindView()
        .navigationTitle("Kinds of Playlists")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              CurrentActivity.shared.endCreating()
            }
          }
        }
    }
  }
}
