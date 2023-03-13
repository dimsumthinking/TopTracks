import MusicKit

extension TopTracksStation {
  public func nextHour() -> [Song] {
    var stacks = [RotationCategory: [TopTracksSong]]()
    stationCategories.forEach { category in
      stacks[category] = songs(for: category)
    }
    return musicClock
      .compactMap { category in
      guard var songs = stacks[category],
            songs.count >= 2 else {return Optional<Song>.none}
      let nextSong = songs.remove(at: (Int.random(in: 0...2)) % 2)
      stacks[category] = songs
        return nextSong.song
    }
  }
}

extension TopTracksStation {
  
  private func songs(for rotationCategory: RotationCategory) -> [TopTracksSong] {
    guard let stack = stack(for: rotationCategory),
          !stack.songs.isEmpty else { return [TopTracksSong]() }
    return stack.orderedSongs
  }
  
  private var stationCategories: [RotationCategory] {
    hasEnoughGold ? stationCreationCategories : stationEssentialCategories
  }
}


