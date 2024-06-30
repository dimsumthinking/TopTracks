import SwiftUI
import ApplicationState

struct HeaderView: View {
  let title: String
}

extension HeaderView {
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
