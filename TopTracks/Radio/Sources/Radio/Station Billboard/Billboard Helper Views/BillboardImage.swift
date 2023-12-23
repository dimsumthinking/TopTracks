import SwiftUI
import Constants
import MusicKit

struct BillboardImage {
  let artwork: Artwork?
}

extension BillboardImage: View {
  var body: some View {
    if let artwork {
      ArtworkImage(artwork,
                   width: Constants.stationListImageSize,
                   height: Constants.stationListImageSize)
      .padding(.trailing)
    } else {
      Image(systemName: Constants.missingArtworkSymbolName)
        .resizable()
        .frame(width: Constants.stationListImageSize,
               height: Constants.stationListImageSize)
        .padding(.trailing)
    }
  }
}
