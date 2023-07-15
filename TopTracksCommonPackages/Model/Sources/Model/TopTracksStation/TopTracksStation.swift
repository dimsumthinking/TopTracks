import Foundation
import SwiftData
import MusicKit



@Model public class TopTracksStation {
    var playlistAsData: Data?
    public var playlistID: String?
    
    var allowRecommendations: Bool = false
    public var buttonPosition: Int16 = 0
    var favorite: Bool = false
    public var isChart: Bool = false
    public var lastTouched: Date = Date()
    public var playlistLastUpdated: Date = Date()
    var stacksLastRotated: Date = Date()
    public var stationID: UUID = UUID()
    var stationLastUpdated: Date = Date()
    public var stationName: String = "Station Name"
    var updateAvailable: Bool = false
    @Relationship(inverse: \TopTracksStack.station) public var stacks: [TopTracksStack]? = [TopTracksStack]()
  
  public init(playlist: Playlist,
              buttonNumber: Int) {
    self.playlistAsData = try? JSONEncoder().encode(playlist)
    self.playlistID = playlist.id.rawValue

    self.playlistLastUpdated = playlist.lastModifiedDate ?? Date()
    self.stationName = playlist.name
    self.isChart = playlist.isChart ?? false
    self.buttonPosition = Int16(buttonNumber)
  }
}


extension TopTracksStation {
    public var name: String {
        stationName
    }
    
    public var playlist: Playlist? {
      guard let playlistAsData else { return nil}
      if let playlist = try? JSONDecoder().decode(Playlist.self, from: playlistAsData) {
        return playlist
      } else {
        return try? PropertyListDecoder().decode(Playlist.self, from: playlistAsData)
      }
    }
    
    public var artwork: Artwork? {
        return playlist?.artwork
    }
    
    public func topTracksSongMatching(_ song: Song) -> TopTracksSong? {
        allSongs.first { topTracksSong in
            topTracksSong.songID == song.id.rawValue
        }
    }
    
    public var topSongs: String {
        guard let powerStack = stack(for: .power)?.songs else {return "Your favorite \(stationName) songs."}
        let songList = powerStack
            .map(\.title)
            .reduce("") {accumulatedSongs, nextSong in
                accumulatedSongs + nextSong + ", "
            }
            .dropLast(2)
        return String(songList)
    }
    
    public var buttonNumber: Int {
        get {
            Int(buttonPosition)
        }
        set {
            buttonPosition = Int16(newValue)
        }
    }
    
    public func stack(for rotationCategory: RotationCategory) -> TopTracksStack? {
        stacks?.first(where: { $0.name == rotationCategory.name})
    }
    
    public var hasEnoughGold: Bool {
        (stack(for: .gold)?.songs?.count ?? 0) > 10
    }
    
    public var hasEnoughGoldForTwoAnHour: Bool {
        (stack(for: .gold)?.songs?.count ?? 0) > 24
    }
    
    public var allSongs: [TopTracksSong] {
        guard let stacks = self.stacks else { return [TopTracksSong]()}
        return stacks.flatMap {stack in
            stack.songs ?? [TopTracksSong]()
        }
    }
    
    public var activeSongs: [TopTracksSong] {
        allSongs.filter{song in stationStandardCategories.contains(song.rotationCategory)}
    }
    
    public var availableSongs: [TopTracksSong] {
        allSongs.filter{song in stationExtendedCategories.contains(song.rotationCategory)}
    }
}

extension TopTracksStation {
  public func changeStack(for topTracksSong: TopTracksSong,
                          to category: RotationCategory) {
    if let destinationStack = stacks?.filter({ stack in stack.name == category.name}).first {
      topTracksSong.stack = destinationStack
      do {
        try topTracksSong.context?.save()
      } catch {
        print("Couldn't save after changing stack")
      }
    }
  }
  
  public func changeStack(for topTrackSongs: [TopTracksSong],
                          to category: RotationCategory) {
    for song in topTrackSongs {
      changeStack(for: song,
                  to: category)
    }
  }
}
