import Foundation
import SwiftData
import MusicKit



@Model public class TopTracksStation {
    var playlistAsData: Data?
    var playlistID: String?
    
    var allowRecommendations: Bool = false
    var buttonPosition: Int16 = 0
    var favorite: Bool = false
    var isChart: Bool = false
    var lastTouched: Date = Date()
    var playlistLastUpdated: Date = Date()
    var stacksLastRotated: Date = Date()
    var stationID: UUID = UUID()
    var stationLastUpdated: Date = Date()
    var stationName: String = "Station Name"
    var updateAvailable: Bool = false
    @Relationship(inverse: \TopTracksStack.station) var stacks: [TopTracksStack]?
    
    
    init(playlist: Playlist,
         songsInStacks: [RotationCategory: [Song]]) {
        self.favorite = false
        self.stationLastUpdated = Date()
        self.playlistLastUpdated = playlist.lastModifiedDate ?? Date()
        self.playlistID = playlist.id.rawValue
        self.stationID = UUID()
        self.stationName = playlist.name
        self.updateAvailable = false
        self.lastTouched = Date()
        self.allowRecommendations = true
        self.playlistAsData = try? PropertyListEncoder().encode(playlist)
        self.stacks = topTracksStacks(songsInStacks: songsInStacks)
        self.isChart = playlist.isChart ?? false
        let numberOfStations: Int = 0
        //TODO: Get number of stations
        //    do {
        //      numberOfStations = try context.count(for: TopTracksStation.fetchRequest())
        //    } catch {
        //      numberOfStations = 0
        //    }
        self.buttonPosition = Int16(numberOfStations)
        self.stacksLastRotated = Date()
    }
}

extension TopTracksStation {
    private func topTracksStacks(songsInStacks: [RotationCategory: [Song]]) -> [TopTracksStack] {
        var topTracksStacks = [TopTracksStack]()
        for category in RotationCategory.allCases {
            let songs = songsInStacks[category] ?? [Song]()
            topTracksStacks.append(TopTracksStack(category: category,
                                                  songs: songs,
                                                  station: self))
            print("Stack", category, "\n \t", songs.count.description)
        }
        return topTracksStacks
    }
    
}

extension TopTracksStation {
    public var name: String {
        stationName
    }
    
    public var playlist: Playlist? {
        guard let playlistAsData,
              let playlist = try? PropertyListDecoder().decode(Playlist.self, from: playlistAsData) else {return nil}
        return playlist
    }
    
    public var artwork: Artwork? {
        //    guard let playlistAsData,
        //          let playlist = try? PropertyListDecoder().decode(Playlist.self, from: playlistAsData) else {return nil}
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
                accumulatedSongs + ", " + nextSong
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

//extension TopTracksStation {
//  public func changeStack(for topTracksSong: TopTracksSong,
//            to category: RotationCategory) {
//    let startingStack = topTracksSong.stack
//    guard startingStack.name != category.rawValue else { return }
//    if let destinationStack = stacks.filter({ stack in stack.name == category.name}).first {
//      destinationStack.addToSongs(topTracksSong)
//      topTracksSong.stack = destinationStack
//      startingStack.removeFromSongs(topTracksSong)
//    }
//  }
//
//  public func changeStack(for topTrackSongs: [TopTracksSong],
//                   to category: RotationCategory) {
//    for song in topTrackSongs {
//      changeStack(for: song,
//                  to: category)
//    }
//  }
//

//  public func changeStationName(to stationName: String) {
//    self.stationName = stationName
////    guard let managedObjectContext else {return}
////    saveIfPossible()
////    do {
////      try managedObjectContext.save()
////    } catch {
////      managedObjectContext.rollback()
////      print("Couldn't change station name")
////    }
//  }




//extension TopTracksStation {
//  public func remove(topTracksSong: TopTracksSong) {
//    changeStack(for: topTracksSong, to: .removed)
//    if let added =  stack(for: .added)?.songs.first {
//      changeStack(for: added, to: topTracksSong.stack.rotationCategory)
//    } else if let gold = stack(for: .gold)?.songs.first {
//      changeStack(for: gold, to: topTracksSong.stack.rotationCategory)
//    } else if let archived = stack(for: .archived)?.songs.first {
//      changeStack(for: archived, to: topTracksSong.stack.rotationCategory)
//    }
//    saveIfPossible()
//  }
//}

//extension TopTracksStation {
//  public func remove(song: Song) {
//    guard let topTracksSong = allSongs.first(where:{ topTracksSong in topTracksSong.songID == song.id.rawValue}) else { return }
//    changeStack(for: topTracksSong, to: .removed)
//    if let added =  stack(for: .added)?.songs.first {
//      changeStack(for: added, to: topTracksSong.stack.rotationCategory)
//    } else if let gold = stack(for: .gold)?.songs.first {
//      changeStack(for: gold, to: topTracksSong.stack.rotationCategory)
//    } else if let archived = stack(for: .archived)?.songs.first {
//      changeStack(for: archived, to: topTracksSong.stack.rotationCategory)
//    }
//    saveIfPossible()
//  }
//}
