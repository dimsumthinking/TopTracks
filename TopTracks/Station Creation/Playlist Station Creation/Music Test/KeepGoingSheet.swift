import SwiftUI

struct KeepGoingSheet {
  let number: Int
  let next: () -> Void
  let finish: () -> Void
  @Binding var showAlert: Bool
}

extension KeepGoingSheet: View {
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "\(howMany).square")
        .font(.largeTitle)
        .padding()
      Text("Congratulations!")
      Text("You've rated \(howMany) songs.")
      HStack {
        Image(systemName: "checklist")
          .font(.largeTitle)
          .padding(.trailing)
        Text("Continue to rank your songs to create a station for this Apple Music playlist.")
        Spacer()
      }
      .padding()
      .foregroundColor(.accentColor)
      .border(Color.accentColor)
      .padding()
      .contentShape(Rectangle())
      .onTapGesture {
        nextSong()
      }
      Text("- or -")
      HStack {
        Image(systemName: "wand.and.stars")
          .font(.largeTitle)
          .padding(.trailing)
        Text("Allow Top Tracks to automatically create a station that includes the songs you selected.")
        Spacer()
      }
      .padding()
      .foregroundColor(.accentColor)
      .border(Color.accentColor)
      .padding()
      .contentShape(Rectangle())
      .onTapGesture {
        finishSettingUpPlaylist()
      }
    }
  }
}

extension KeepGoingSheet {
  private func nextSong() {
    showAlert = false
    next()
  }
  private func finishSettingUpPlaylist() {
    showAlert = false
    finish()
  }
  private var howMany: String {
    number.description
  }
}

//struct Popup10_Previews: PreviewProvider {
//  static var previews: some View {
//    Popup10()
//  }
//}
