import SwiftUI

struct SpiceListRefinementView {
  @ObservedObject var songs: MusicTestSongs
  @State private var moveOn = false
  @State private var mustMoveOn = false
}

extension SpiceListRefinementView: View {
  var body: some View {
    VStack {
      if mustMoveOn {
        Text(songs.displayMessage(for: .spice))
      } else {
        Text(songs.removeMessageforSpice())
      }
      List {
        ForEach(songs.songs(in: .spice)) {result in
          HStack {
            VStack(alignment: .leading) {
              Text(result.song.title).bold()
              Text(result.song.artistName)
            }
            Spacer()
            result.rotationCategory.symbol
              .font(.largeTitle)
              .padding()
          }
          .foregroundColor(result.rotationCategory.color)
          .contentShape(Rectangle())
          .onTapGesture {
            if !mustMoveOn {
              songs.setCategory(of: result, to: .notIncluded)
            }
            updateMustMoveOn()
          }
        }
      }
      
      Button(action: {moveOn = true}){
        Text("Next")
          .padding()
          .padding(.horizontal)
      }
      .padding(30)
      .buttonStyle(.borderedProminent)
      .padding()
      NavigationLink(isActive: $moveOn) {
        StationCreationView(songs: songs,
                            spice: true)
      } label: {
        EmptyView()
      }
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle(songs.playlist.name)
    .modifier(StationBuildCancellation())
  }
}

extension SpiceListRefinementView {
  private func updateMustMoveOn() {
    mustMoveOn = songs.numberOfSongs(in: .spice) <= songs.minimumNumberOfSpiceSongs
  }
}
