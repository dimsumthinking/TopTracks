import MusicKit
import SwiftUI
import Foundation
import ApplicationState
import PlaylistSearchShared

public struct PlaylistImporterView: View {
  let url: URL
  @State private var message = ""
  @State private var playlist: Playlist?
  @State private var isError = false
  
  public init(url: URL) {
    self.url = url
  }
}

extension PlaylistImporterView {
  public var body: some View {
    NavigationStack {
      if let playlist {
        PlaylistSongsView(playlist: playlist)
          .navigationTitle(playlist.name)
      } else {
        VStack {
          Spacer()
          Text("Importing...")
          Spacer()
          Text(message)
            .foregroundColor(isError ? .red : .primary)
          Spacer()
        }
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              CurrentActivity.shared.endImporting()
            } label: {
              Text("Cancel")
            }
          }
        }
      }
    }
    .task {
        do {
          let playlist = try await fetchPlaylist(for: url)
          message = playlist.name
          try await Task.sleep(for: .seconds(2))
          self.playlist = playlist
        } catch {
          message = error.localizedDescription
          isError = true
        }
      }
  }

}

