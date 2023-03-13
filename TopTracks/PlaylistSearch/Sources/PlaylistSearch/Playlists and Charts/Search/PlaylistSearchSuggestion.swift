
import MusicKit
import Combine

@MainActor
class PlaylistSearchSuggestion: ObservableObject {
  @Published var searchSuggestions: [String: String] = [:] // displayterm, searchterm
  private var haveNotSearchedSubTerms = true
  
  @Published var suggestions: [MusicCatalogSearchSuggestionsResponse.Suggestion] = []
}

extension PlaylistSearchSuggestion {
  func searchSuggestions(for term: String) {
    searchSuggestions.removeAll()
    haveNotSearchedSubTerms = true
    Task {
      try await playlistSearchSuggestions(term: term)
    }
  }
  
  private func playlistSearchSuggestions(term: String) async throws {
    let request = MusicCatalogSearchSuggestionsRequest(term: term,
                                                       includingTopResultsOfTypes: [Playlist.self])
    
    let suggestions = try await request.response().suggestions
      for suggestion in suggestions {
        self.searchSuggestions[suggestion.displayTerm] = suggestion.searchTerm
        if !self.suggestions.contains(suggestion) {
          self.suggestions.append(suggestion)
        }
      }
    if haveNotSearchedSubTerms {
      haveNotSearchedSubTerms = false
      try await downloadMoreSuggestions()
    }
  }
}

extension PlaylistSearchSuggestion {
  private func downloadMoreSuggestions() async throws {
    for searchTerm in searchSuggestions.values {
      try await playlistSearchSuggestions(term: searchTerm)
    }
  }
}

