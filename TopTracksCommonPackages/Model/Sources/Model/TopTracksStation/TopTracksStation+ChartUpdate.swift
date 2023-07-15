import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  public func updateWith(songs songsToAdd: [Song],
                         for playlist: Playlist) {
    guard let context,
    let playlistAsData = try? PropertyListEncoder().encode(playlist),
    let playlistLastModifiedDate = playlist.lastModifiedDate,
    let stacks else { return }
    self.playlistAsData = playlistAsData
    stationLastUpdated = Date()
    playlistLastUpdated = playlistLastModifiedDate
    var movedSongs = [Song]()
    var newStacks = splitSongsIntoCategories(songs: songsToAdd)
    for song in activeSongs { // moves or deletes current songs
      let (category, returnedSongs) = categoryFor(songTitle: song.title, in: newStacks)
      if let category  {
        changeStack(for: song, to: category)
        newStacks[category] = returnedSongs
        if let movedSong = song.song {
          movedSongs.append(movedSong)
        }
      } else {
        context.delete(song)
      }
    }
    
    for topTracksStack in stacks { // add remaining songs to station
      if let categorySongs = newStacks[topTracksStack.rotationCategory] {
        for song in categorySongs {
          if !movedSongs.contains(song) {
            let topTracksSong = TopTracksSong(song: song)
            topTracksStack.songs?.append(topTracksSong)
            topTracksSong.stack = topTracksStack
          }
        }
      }
    }
    do {
      try context.save()
    } catch {
      print("Unable to update chart")
    }
  }
  
  
 
  
  
  
  func categoryFor(songTitle: String, in categorizedSongs: [RotationCategory: [Song]] ) -> (RotationCategory?, [Song]) {
    var songsCategory: RotationCategory? = nil
    var returnedSongs: [Song] = []
    for (category, songsInCategory) in categorizedSongs {
      let titles = songsInCategory.map(\.title)
      if titles.contains(songTitle) {
        songsCategory = category
        if let index = titles.firstIndex(of: songTitle) {
          var songsInCategory = songsInCategory
          songsInCategory.remove(at: index)
          returnedSongs = songsInCategory
        }
        
      }
    }
    return (songsCategory, returnedSongs)
  }
}
