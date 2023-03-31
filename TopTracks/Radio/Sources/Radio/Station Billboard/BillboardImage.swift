import SwiftUI
import Constants
import MusicKit

struct BillboardImage {
  let artwork: Artwork
}

extension BillboardImage: View {
  var body: some View {
    ArtworkImage(artwork,
                 width: Constants.stationListImageSize,
                 height: Constants.stationListImageSize)
    .padding(.trailing)
  }
}
