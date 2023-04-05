import Foundation
import Model

public enum TopTracksAppActivity {
  case enjoying
  case creating
  case viewingOrEditing(topTracksStation: TopTracksStation)
  case importing(url: URL)
}

extension TopTracksAppActivity: Equatable {
  public static func ==(lhs: TopTracksAppActivity, rhs: TopTracksAppActivity) -> Bool {
    switch (lhs, rhs) {
    case (.enjoying, .enjoying), (.creating, .creating):
      return true
    case (.importing( _), .importing( _)):
      return true
    case (.viewingOrEditing(let lhs), .viewingOrEditing(let rhs)):
      return lhs == rhs
    default:
      return false
    }
  }
}
