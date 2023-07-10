import SwiftUI
import ApplicationState

struct AddStationButton {
  
}

extension AddStationButton: View {
  var body: some View {
    Button {
      CurrentActivity.shared.beginCreating()
    } label: {
      Image(systemName: "plus")
    }
  }
}
