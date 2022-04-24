import SwiftUI

struct Popup10 {
  let next: () -> Void
  let finish: () -> Void
  @Binding var show10Alert: Bool
}

extension Popup10: View {
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "10.square")
        .font(.largeTitle)
        .padding()
      Text("Congratulations!")
      Text("You've rated ten songs.")
      Button("Keep going and pick 15 more songs for a mini-station or 30 more songs for a full station", action: nextSong)
        .buttonStyle(.bordered)
        .padding()
        .padding(.horizontal)
      Text("- or -")
      Button("Allow Top Tracks to pick 15 songs to create a mini-station that includes the songs you selected",
             role: .destructive,
             action: finishSettingUpPlaylist)
        .buttonStyle(.bordered)
        .padding()
        .padding(.horizontal)
    }
  }
}

extension Popup10 {
  private func nextSong() {
    show10Alert = false
    next()
  }
  private func finishSettingUpPlaylist() {
    show10Alert = false
    finish()
  }
}

//struct Popup10_Previews: PreviewProvider {
//  static var previews: some View {
//    Popup10()
//  }
//}
