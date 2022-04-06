import SwiftUI

struct MusicTestOverview {
  @Binding var testIsRunning: Bool
  let action: () -> Void
  let count: Int
}

extension MusicTestOverview: View {
  var body: some View {
    VStack {
      if count > 0 {
      Text("Quickly rank the \(numberOfSongs) songs in \n this Apple Music Playlist.")
        .multilineTextAlignment(.center)
        .padding()
        .padding(.horizontal)
      } else {
        Text("Loading...")
          .foregroundColor(.secondary)
          .font(.largeTitle)
      }
      Button("Start the Music Test"){
        testIsRunning = true
        action()
      }
      .disabled(count <= 0)
      .padding()
      .buttonStyle(.borderedProminent)
      if count > 50 {
        Text("Once you've chosen 40 songs \n we'll create a station.")
          .multilineTextAlignment(.center)
          .padding()
          .padding(.horizontal)
      }
    }
  }
}

extension MusicTestOverview {
  private var numberOfSongs: String {
    count > 0 ? count.description : ""
  }
}

struct MusicTestOverview_Previews: PreviewProvider {
  static var previews: some View {
    MusicTestOverview(testIsRunning: .constant(false),
                      action: {},
                      count: 5)
  }
}
