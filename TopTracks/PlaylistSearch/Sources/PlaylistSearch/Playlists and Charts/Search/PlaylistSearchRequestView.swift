import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct PlaylistSearchRequestView: View {
  @State private var searchTerm = ""
  @State private var startSearch = false
  @State private var searchSuggester = PlaylistSearchSuggestion()
  @FocusState private var enteringSearch: Bool
}

extension PlaylistSearchRequestView {
  
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
          .focused($enteringSearch)
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
    #if !os(macOS)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Cancel") {
          CurrentActivity.shared.endCreating()
        }
      }
    }
    #endif
    .navigationDestination(isPresented: $startSearch) {
      PlaylistSearchResultsView(term: escapedSearchTerm)
        .navigationTitle(searchTerm)
    }
    .onAppear {
      enteringSearch = true
    }
  }
}

extension PlaylistSearchRequestView {
  private var escapedSearchTerm: String {
    searchTerm.replacingOccurrences(of: " ", with: "+")
  }
}

