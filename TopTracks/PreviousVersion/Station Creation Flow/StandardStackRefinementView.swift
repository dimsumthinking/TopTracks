import SwiftUI

struct StandardStackRefinementView {
  @ObservedObject var songs: MusicTestSongs
  @State private var moveOn = false
  @State private var cantMoveOn = false
  let category: RotationCategory
}

extension StandardStackRefinementView: View {
  var body: some View {
    VStack {
      Text(songs.displayMessage(for: category))
      List {
        ForEach(songs.songs(in: category)) {result in
          HStack {
            result.rotationCategory.symbol
              .font(.largeTitle)
              .padding()
            VStack(alignment: .leading) {
              Text(result.song.title).bold()
              Text(result.song.artistName)
            }
            Spacer()
          }
          .foregroundColor(result.rotationCategory.color)
        }
      }
      Button(action: {
        moveOn = true
      }){
        Text("Next")
          .padding()
          .padding(.horizontal)
      }
      .padding(30)
      .buttonStyle(.borderedProminent)
      .padding()
      NavigationLink(isActive: $moveOn) {
        if category.hasNext
            && category != .added {
          StandardStackRefinementView(songs: songs,
                                      category: category.next)
        } else if category == .added
                    && songs.numberOfCategories == 4
                    && songs.minimumNumberOfSpiceSongs <= songs.numberOfSongs(in: .spice) {
          SpiceListRefinementView(songs: songs)
        } else {
          StationCreationView(songs: songs,
                              spice: false)
        }
      } label: {
        EmptyView()
      }
    }
    .sheet(isPresented: $cantMoveOn,
           onDismiss: {
      cantMoveOn = (songs.numberOfSongs(in: category) < songs.minimumNumberOfSongsPerCategory)
      || (songs.numberOfSongs(in: category) > songs.maximumNumberOfSongsPerCategory)
    }) {
      if songs.numberOfSongs(in: category) < songs.minimumNumberOfSongsPerCategory {
        VStack {
          Text(songs.addMessage(for: category )).multilineTextAlignment(.center)
          AdjustSongListView(songs: songs,
                             currentCategory: category.next,
                             targetCategory: category,
                             up: true,
                             cantMoveOn: $cantMoveOn)
        }
      } else if songs.numberOfSongs(in: category) > songs.maximumNumberOfSongsPerCategory {
        VStack {
          Text(songs.removeMessage(for: category)).multilineTextAlignment(.center)
          AdjustSongListView(songs: songs,
                             currentCategory: category,
                             targetCategory: category.next,
                             up: false,
                             cantMoveOn: $cantMoveOn)
        }
      } else {
        Button(action: {
          cantMoveOn = false
        }){
          Text("View \(category.description) tracks")
            .padding()
            .padding(.horizontal)
        }
        .padding(30)
        .buttonStyle(.borderedProminent)
        .padding()      }
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle(songs.playlist.name)
    .modifier(StationBuildCancellation())
    .onAppear{
      switch songs.numberOfSongs(in: category) {
      case ..<songs.minimumNumberOfSongsPerCategory:
        cantMoveOn = true
      case (songs.maximumNumberOfSongsPerCategory + 1)...:
        cantMoveOn = true
      default:
        cantMoveOn = false
      }
    }
  }
}
