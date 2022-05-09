import SwiftUI
import MusicKit

struct MusicTestOverview {
  @Binding var isSelectingSongs: Bool
  let fillAutomatically: () -> Void
  let runTest: () -> Void
  let count: Int
  let artwork: Artwork?
}

extension MusicTestOverview: View {
  var body: some View {
    VStack {
      if let artwork = artwork {
        Spacer()
        ArtworkImage(artwork, width: fullArtworkImageSize, height: fullArtworkImageSize)
      }
      Spacer()
      if count > 0 {
        HStack {
          Image(systemName: "wand.and.stars")
            .font(.largeTitle)
            .padding(.trailing)
          Text("Automatically create a station from this Apple Music Playlist")
          Spacer()
        }
        .padding()
        .foregroundColor(.accentColor)
        .border(Color.accentColor)
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
          isSelectingSongs = true
          fillAutomatically()
        }
        HStack {
          Image(systemName: "tuningfork")
            .font(.largeTitle)
            .padding(.trailing)
          Text("Begin a Music Test where you can quickly rank the songs in this Apple Music Playlist.")
          Spacer()
        }
        .padding()
        .foregroundColor(.accentColor)
        .border(Color.accentColor)
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
          isSelectingSongs = true
          runTest()
        }
      } else {
        Text("Loading...")
          .foregroundColor(.secondary)
          .font(.largeTitle)
      }
          Spacer()
    }
  }
}

extension MusicTestOverview {
  private var numberOfSongs: String {
    count > 0 ? count.description : ""
  }
}

//struct MusicTestOverview_Previews: PreviewProvider {
//  static var previews: some View {
//    MusicTestOverview(testIsRunning: .constant(false),
//                      action: {},
//                      count: 5)
//  }
//}
