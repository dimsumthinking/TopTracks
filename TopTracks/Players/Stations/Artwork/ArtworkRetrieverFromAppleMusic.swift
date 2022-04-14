import MusicKit
//import Combine
//
//class ArtworkRetrieverFromAppleMusic: ObservableObject  {
//  @Published private(set) var artwork: Artwork?
//
//}
//@MainActor
struct ArtworkRetrieverFromAppleMusic {
   static func artwork(for song: Song) async throws  -> Artwork?  {
    let request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: song.id)
    let response = try await request.response()
   return response.items.first?.artwork
  }
}

