import MusicKit

extension TopTracksStation {
  var songsInCategories: [SongInCategory] {
    var songsInCat = [SongInCategory]()
    for stack in stacks {
      for topTracksSong in stack.songs {
        if let song = topTracksSong.song {
        songsInCat.append(SongInCategory(for: song,
                                         rotationCategory: stack.rotationCategory))
        }
      }
    }
    return songsInCat
  }

}
