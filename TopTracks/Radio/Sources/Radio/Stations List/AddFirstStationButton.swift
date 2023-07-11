
import SwiftUI
import ApplicationState

struct AddFirstStationButton {
  
}

extension AddFirstStationButton: View {
  var body: some View {
    Button {
      CurrentActivity.shared.beginCreating()
    } label: {
      Text("Create your first station")
        .font(.largeTitle)
        .foregroundStyle(Color.yellow)
    }
  }
}
