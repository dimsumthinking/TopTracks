import SwiftUI
import MusicKit

struct NewStationTrackSelectionView {
  @Environment(\.managedObjectContext) private var viewContext
  @StateObject private var songsInPlaylist: NewStationSongsInPlaylist
  private var name: String
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)]) private var stations: FetchedResults<TopTracksStation>
  @EnvironmentObject private var stationConstructionStatus: StationContructionStatus

  private let playlist: Playlist
}

extension NewStationTrackSelectionView {
  init(for playlist: Playlist) {
    self.init(songsInPlaylist: NewStationSongsInPlaylist(playlist),
              name: playlist.name,
    playlist: playlist)
    
  }
}

extension NewStationTrackSelectionView: View {
  var body: some View {
    VStack(spacing: 0) {
      Text("Rate these songs. The more you rank the better your station will be!")
        .multilineTextAlignment(.center)

      List($songsInPlaylist.songsAndRatings) {$songAndRating in
        NewStationIndividualTrackView(songAndRating: $songAndRating)
      }
      Text("Rank \(numberLeftToRank) more to unlock")
        .foregroundColor(numberLeftToRank > 0 ? .primary : .clear)
        .padding(.top)
      HStack {
        Button("Create a station",
               action: createStation)
          .disabled(notEnoughSongs)
        
        Spacer()
        Button("Sort top to bottom",
               action: sortTheSongs)
          .disabled(nothingToSort)
      }
      .padding()
    }
    .navigationTitle(name)
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
    .onDisappear {
      previewPlayer.audioPlayer = nil
    }
  }
}

extension NewStationTrackSelectionView {
  private var numberOver0: Int {
    songsInPlaylist.songsAndRatings.filter{$0.rating > 0}.count
  }
  private var numberLeftToRank: Int {
    targetNumberOfSongsInPlaylist - numberOver0
  }
  private var targetNumberOfSongsInPlaylist: Int {
    min(preferredMinimumTracksForStation, songsInPlaylist.songsAndRatings.count)
  }
  private var notEnoughSongs: Bool {
    numberOver0 < targetNumberOfSongsInPlaylist
  }
  private var nothingToSort: Bool {
    numberOver0 == 0
  }
  private func sortTheSongs() {
    self.songsInPlaylist.songsAndRatings
    = self.songsInPlaylist.songsAndRatings.sorted{$0.rating > $1.rating}
  }
  private func createStation() {
    songsInPlaylist.createStation(among: stations.map(\.stationName),
                                  context: viewContext)
    stationConstructionStatus.isCreatingNew = false

  }
}


