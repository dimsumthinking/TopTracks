import SwiftUI
import MusicKit
import ApplicationState

public struct PlaylistSearchRequestView {
  @State private var searchTerm = ""
  @State private var startSearch = false
  @StateObject private var searchSuggester = PlaylistSearchSuggestion()
}

extension PlaylistSearchRequestView: View {
  public var body: some View {
    VStack {
      ZStack {
        TextField("Playlist Search Term", text: $searchTerm)
          .onSubmit {
            if searchTerm.count > 2 {
              startSearch = true
            }
          }
          .padding()
          .multilineTextAlignment(.center)
          .background(Color.secondary.opacity(0.2))
        HStack {
          Spacer()
          
          Button {
            searchTerm = ""
            searchSuggester.resetSuggestions()
          } label: {
            Image(systemName: "x.circle.fill")
          }
          .disabled(searchTerm.isEmpty)
          .tint(.secondary)
          .padding(.trailing)
        }
      }
      .padding()
      HStack {
        Button("Suggestions...") {
          searchSuggester.searchSuggestions(for: escapedSearchTerm)
        }
        .disabled(searchTerm.count < 3)
        .padding(.leading)
        Spacer()
        Button("Search") {
          startSearch = true
        }
        .disabled(searchTerm.count < 3)
        .padding(.trailing)
      }
      .buttonStyle(.borderedProminent)
      
      Spacer()
      if !searchSuggester.searchSuggestions.isEmpty {
        List(searchSuggester.suggestions) { suggestion in
          NavigationLink(suggestion.displayTerm) {
            PlaylistSearchResultsView(term: suggestion.searchTerm)
              .navigationTitle(suggestion.displayTerm)
          }
        }
      }

    }
    .navigationTitle("Playlist Search")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Cancel") {
          ApplicationState.shared.endCreating()
        }
      }
    }
    .navigationDestination(isPresented: $startSearch) {
      PlaylistSearchResultsView(term: escapedSearchTerm)
        .navigationTitle(searchTerm)
    }
  }
}

extension PlaylistSearchRequestView {
  private var escapedSearchTerm: String {
    searchTerm.replacingOccurrences(of: " ", with: "+")
  }
}

