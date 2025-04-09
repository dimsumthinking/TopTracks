import SwiftUI
import Constants
import MusicKit

struct BillboardImage: View {
  let artwork: Artwork?
}

extension BillboardImage {
  @ViewBuilder
  var body: some View {
    if let artwork {
      ArtworkImage(artwork,
                   width: Constants.stationListImageSize,
                   height: Constants.stationListImageSize)
      .aspectRatio(1, contentMode: .fit)
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
