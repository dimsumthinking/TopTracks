//import SwiftUI
//import MusicKit
//
//struct NewStationSongSelectionView {
//  @Environment(\.managedObjectContext) private var viewContext
//  @StateObject private var songsInPlaylist: NewStationSongsInPlaylist
//  private var name: String
//  @FetchRequest(entity: TopTracksStation.entity(),
//                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
//                                                   ascending: true)]) private var stations: FetchedResults<TopTracksStation>
//  @EnvironmentObject private var topTracksStatus: TopTracksStatus
//
//  private let playlist: Playlist
//  @Binding var moveOn: Bool
//}
//
//extension NewStationSongSelectionView {
//  init(for playlist: Playlist,
//       moveOn: Binding<Bool>) {
//    self.init(songsInPlaylist: NewStationSongsInPlaylist(playlist),
//              name: playlist.name,
//    playlist: playlist,
//    moveOn: moveOn)
//  }
//}
//
//extension NewStationSongSelectionView: View {
//  var body: some View {
//    VStack(spacing: 10) {
//      HStack {
//        Button("Create a station",
//               action: createStation)
//          .disabled(notEnoughSongs)
//        
//        Spacer()
//        Group {
//          Button(action: sortTheSongs) {
//            Image(systemName: "arrow.up.arrow.down")
//          }
//          .disabled(nothingToSort)
//          Button(action: sortTheSongs){
//            Image(systemName: "info")
//          }
//        }
//      }
//      .buttonStyle(.borderedProminent)
//      .padding()
//      if (minNumberLeftToRank > 0) {
//        Text("Rank \(minNumberLeftToRank) more to unlock")
//      } else if (targetNumberLeftToRank > 0) {
//        Text("Unlocked - Rank \(targetNumberLeftToRank) more if you can")
//      }
//      List($songsInPlaylist.songsAndRatings) {$songAndRating in
//        NewStationIndividualTrackView(songAndRating: $songAndRating)
//          .foregroundColor(songAndRating.rotationCategory.color)// ?? .primary)
//          .onChange(of: songAndRating) {_ in self.assignCategories()}
//      }
//    }
//    .onDisappear {
//      previewPlayer.audioPlayer = nil
//    }
//  }
//}
//
//extension NewStationSongSelectionView {
//  private var numberOver0: Int {
//    songsInPlaylist.songsAndRatings.filter{$0.rating > 0}.count
//  }
//  private var minNumberLeftToRank: Int {
//    targetNumberOfSongsInPlaylist - numberOver0
//  }
//  private var targetNumberLeftToRank: Int {
//    maxNumberOfSongsInPlaylist - numberOver0
//  }
//  private var anyLeftToRank: Bool {
//    numberOver0 < songsInPlaylist.songsAndRatings.count
//  }
//  private var targetNumberOfSongsInPlaylist: Int {
//    min(preferredMinimumTracksForStation, songsInPlaylist.songsAndRatings.count)
//  }
//  private var maxNumberOfSongsInPlaylist: Int {
//    min(3 * preferredMaximumSongsPerRotationCategory, songsInPlaylist.songsAndRatings.count)
//  }
//  private var notEnoughSongs: Bool {
//    nothingToSort || numberOver0 < targetNumberOfSongsInPlaylist
//  }
//  private var nothingToSort: Bool {
//    numberOver0 < 2
//  }
//  private func sortTheSongs() {
//    self.songsInPlaylist.songsAndRatings
//    = self.songsInPlaylist.songsAndRatings.sorted{$0.rating > $1.rating}
//    self.assignCategories()
//  }
//  private func assignCategories() {
//    self.songsInPlaylist.assignCategories(for: numberOver0, outOf: maxNumberOfSongsInPlaylist)
//  }
//  private func createStation() {
//    songsInPlaylist.createStation(among: stations.map(\.stationName),
//                                  context: viewContext)
//    topTracksStatus.isCreatingNew = false
//  }
//}
