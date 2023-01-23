import SwiftUI
import MusicKit

public struct SongTitleView {
  let title: String
  public init(_ title: String) {
    self.title = title
  }
}

extension SongTitleView: View {
  public var body: some View {
    Text(title)
      .bold()
  }
}
