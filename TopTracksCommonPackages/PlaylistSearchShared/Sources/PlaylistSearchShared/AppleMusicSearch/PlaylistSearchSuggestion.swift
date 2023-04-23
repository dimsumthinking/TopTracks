
import MusicKit
import Combine

@MainActor
public class PlaylistSearchSuggestion: ObservableObject {
  @Published public private(set) var searchSuggestions: [String: String] = [:] // displayterm, searchterm
  private var haveNotSearchedSubTerms = true
  
  @Published public private(set) var suggestions: [MusicCatalogSearchSuggestionsResponse.Suggestion] = []
  public init(){}
}

extension PlaylistSearchSuggestion {
  public func searchSuggestions(for term: String) {
    resetSuggestions()
    haveNotSearchedSubTerms = true
    Task {
      try await playlistSearchSuggestions(term: term)
    }
  }
  
  public func resetSuggestions() {
    searchSuggestions.removeAll()
    suggestions.removeAll()
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

