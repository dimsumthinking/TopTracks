import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct PlaylistSearchRequestView {
  @State private var searchTerm = ""
  @State private var startSearch = false
  @StateObject private var searchSuggester = PlaylistSearchSuggestion()
  @FocusState private var enteringSearch: Bool
}

extension PlaylistSearchRequestView: View {
  public var body: some View {
    VStack {
      HeaderView(title: "Open Search")
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
          .font(.headline)
      

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
        ScrollView {
          LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(searchSuggester.suggestions) {suggestion in
              NavigationLink(value: suggestion) {
                Button{
                  
                } label: {
                  HStack {
                    Spacer()
                    Text(suggestion.displayTerm)
                    Spacer()
                  }
                }
                
              }
            }
          }
        }
        .navigationDestination(for: MusicCatalogSearchSuggestionsResponse.Suggestion.self) { suggestion in
          VStack {
            HeaderView(title: suggestion.displayTerm)
            PlaylistSearchResultsView(term: suggestion.searchTerm)
          }
        }
//        List(searchSuggester.suggestions) { suggestion in
//          NavigationLink(suggestion.displayTerm) {
//            PlaylistSearchResultsView(term: suggestion.searchTerm)
//              .navigationTitle(suggestion.displayTerm)
//          }
//        }
      }

    }
//    .navigationTitle("Playlist Search")
    .navigationDestination(isPresented: $startSearch) {
      VStack {
        HeaderView(title: searchTerm)
        PlaylistSearchResultsView(term: escapedSearchTerm)
      }
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

