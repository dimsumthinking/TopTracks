import SwiftUI
import ApplicationState

struct AddStationButton: View {
  
}

extension AddStationButton {
  var body: some View {
    Button {
      CurrentActivity.shared.beginCreating()
    } label: {
      Image(systemName: "plus")
    }
  }
}
