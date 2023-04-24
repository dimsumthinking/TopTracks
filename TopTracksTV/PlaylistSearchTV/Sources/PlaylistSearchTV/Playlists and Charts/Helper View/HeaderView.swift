import SwiftUI
import ApplicationState

struct HeaderView {
  let title: String
}

extension HeaderView: View {
  var body: some View {
    ZStack {
      HStack {
        Spacer()
        Button {
          CurrentActivity.shared.endCreating()
        } label: {
          Text("Current Stations")
        }
      }
      Text(title)
        .font(.title)
    }
    .padding()
  }
}
