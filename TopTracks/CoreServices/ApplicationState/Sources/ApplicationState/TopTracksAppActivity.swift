import Foundation

public enum TopTracksAppActivity {
  case playing
  case creating
  case importing(url: URL?)
}

extension TopTracksAppActivity: Equatable {
  public static func ==(lhs: TopTracksAppActivity, rhs: TopTracksAppActivity) -> Bool {
    switch (lhs, rhs) {
    case (.playing, .playing), (.creating, .creating):
      return true
    case (.importing( _), .importing( _)):
      return true
    default:
      return false
    }
  }
}