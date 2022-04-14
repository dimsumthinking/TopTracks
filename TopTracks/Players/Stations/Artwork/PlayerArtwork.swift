import SwiftUI
import MusicKit

struct PlayerArtwork {
  let song: Song
  let size: Double
  let retrievedArtwork: Artwork?
}


extension PlayerArtwork: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.secondary.opacity(0.2))
        .frame(width: size,
               height: size,
               alignment: .center)
        .padding()
      if let artwork = ArtworkRetrieverFromStore.artwork(for: song) {
        ArtworkImage(artwork,
                     width: size)
        .padding()
      }  else {
        if let artwork = retrievedArtwork {//retriever.artwork {
        ArtworkImage(artwork,
                     width: size)
        .padding()
        }
      }
    }
  }
}

//struct PlayerArtwork_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerArtwork()
//    }
//}
