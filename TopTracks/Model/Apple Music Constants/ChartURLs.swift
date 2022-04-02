import MusicKit
import Foundation

class ChartURLs {
}

extension ChartURLs {
  private func baseComponents()  async -> URLComponents{
    let storefront = (try? await MusicDataRequest.currentCountryCode) ?? "us"
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.music.apple.com"
    components.path = "/v1/catalog/\(storefront)/charts"
    return components
  }
}

//extension ChartURLs {
//  func cityCharts() async -> URLComponents {
//    var components = await baseComponents()
//    var queryItems: [URLQueryItem] = [URLQueryItem(name: "types", value: "songs")]
//  }
//}
//
//private func createURL() async throws -> URL {
//       let storefront = try await MusicDataRequest.currentCountryCode
//
//       var components = URLComponents()
//       components.scheme = "https"
//
//
//       var queryItems: [URLQueryItem] = []
//
//       queryItems.append(URLQueryItem(name: "types", value: types))
//
//       if let genre = genre {
//           queryItems.append(URLQueryItem(name: "genre", value: genre.rawValue))
//       }
//
//       if let limit = limit {
//           queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
//       }
//
//       components.queryItems = queryItems
//
//       guard let url = components.url else { throw URLError(.badURL) }
//       return url
//   }
