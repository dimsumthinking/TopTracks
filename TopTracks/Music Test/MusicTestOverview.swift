import SwiftUI

struct MusicTestOverview {
  @Binding var testIsRunning: Bool
  let action: () -> Void
}

extension MusicTestOverview: View {
  var body: some View {
    VStack {
      Text("Quickly rank each song in \n this Apple Music Playlist.")
        .multilineTextAlignment(.center)
        .padding()
        .padding(.horizontal)
      Button("Start the Music Test"){
        testIsRunning = true
        action()
      }
      .padding()
      .buttonStyle(.borderedProminent)
      Text("Don't worry, you'll be given a chance to review and adjust your decisions.")
        .multilineTextAlignment(.center)
        .padding()
        .padding(.horizontal)
    }
  }
}

struct MusicTestOverview_Previews: PreviewProvider {
  static var previews: some View {
    MusicTestOverview(testIsRunning: .constant(false),
                      action: {})
  }
}
