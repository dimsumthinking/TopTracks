func motionMoving(from fromCategory: RotationCategory,
                  to toCategory: RotationCategory,
                  given currentMotion: SongMotion) -> SongMotion {
  switch (fromCategory, toCategory) {
  case (.power, .heavy), (.heavy, .medium), (.medium, .light), (.light, .gold):
    if currentMotion == .down {
      return .downPlus
    } else {
      return .down
    }
  case (.power, .medium), (.heavy, .light), (.medium, .gold):
    return .downPlus
  case (.heavy, .power), (.medium, .heavy), (.light, .medium), (.gold, .light):
    if currentMotion == .up {
      return .upPlus
    } else {
      return .up
    }
  case (.medium, .power), (.light, .heavy), (.gold, .medium):
    return .upPlus
  case (.added, _):
    return .up
  default:
    return .same
  }
}

