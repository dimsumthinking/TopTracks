import SwiftUI

struct Popup10 {
  let next: () -> Void
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
//      EmptyView()
//      Text("You can use the back button")
//      Text("To go back and change a rating.")
      Button("Keep going", action: nextSong)
        .buttonStyle(.bordered)
        .padding()
    }
  }
}

extension Popup10 {
  private func nextSong() {
    show10Alert = false
    next()
  }
}

//struct Popup10_Previews: PreviewProvider {
//  static var previews: some View {
//    Popup10()
//  }
//}
