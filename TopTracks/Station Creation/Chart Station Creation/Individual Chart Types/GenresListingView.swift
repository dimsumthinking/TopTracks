import SwiftUI
import MusicKit
import Foundation

struct GenresListingView {
  @State private var genres: [Genre] = []
  @State private var filterText: String = ""
  @State private var artworkForGenre: [Genre: Artwork] = [:]
}
extension GenresListingView: View {
  var body: some View {
    List {
      ForEach(filteredGenres){genre in
        NavigationLink {
          StationPreviewForGenre(genre: genre)
        } label: {
          HStack {
            AppleMusicPlaylistArtworkView(artwork: artworkForGenre[genre])
            VStack(alignment: .leading) {
              Text("Top Songs in:")
                .foregroundColor(.secondary)
              HStack{
                Spacer()
                Text(genre.name)
                  .font(.headline)
              }
            }
            .padding()
          }
        }
      }
    }
    .searchable(text: $filterText)
    .onAppear {
      Task {
        await genreSearch()
        await artworkForGenres()
      }
    }
    .navigationTitle("Top Songs")
    .modifier(NewStationCancellation())
  }
}

extension GenresListingView {
  private var filteredGenres: [Genre] {
    if filterText.isEmpty {
      return genres
    } else {
      return genres.filter{genre in
        genre.name.lowercased().contains(filterText.lowercased())
      }
    }
  }
}

extension GenresListingView {
  private func genreSearch()  async {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.music.apple.com"
    components.path = "/v1/catalog/us/genres"
    guard let url = components.url,
          let genreResponse = try? await MusicDataRequest(urlRequest: URLRequest(url: url)).response(),
          let genreContainer = try? JSONDecoder().decode(GenresData.self,
                                                         from: genreResponse.data)
    else {return}
    genres = genreContainer.data
  }
}

extension GenresListingView {
  private func artworkForGenres() async {
    for genre in genres {
      Task {
        if let artwork = await StationFiller.topArtwork(for: genre) {
          artworkForGenre[genre] = artwork
        }
      }
    }
  }
}


struct GenresListingsView_Previews: PreviewProvider {
  static var previews: some View {
    GenresListingView()
  }
}

fileprivate struct GenresData: Codable {
  var data: [Genre]
}


