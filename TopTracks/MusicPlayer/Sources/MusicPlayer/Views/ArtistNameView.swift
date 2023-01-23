import SwiftUI
import MusicKit

public struct ArtistNameView {
  let artistName: String
  public init(_ artistName: String) {
    self.artistName = artistName
  }
}

extension ArtistNameView: View {
  public var body: some View {
    Text(artistName)
      .foregroundColor(.secondary)
  }
}
