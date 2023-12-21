import SwiftUI
import Model

struct CloudActivityView {
  @State private var activity: CloudActivity?
}

extension CloudActivityView: View {
  var body: some View {
    HStack {
      Spacer()
      if let _ = self.activity {
        Image(systemName: "icloud.and.arrow.down")
          .imageScale(.large)
        Text("Checking iCloud for stations")
        ProgressView().padding()
      }
      Spacer()
    }
    .task {
      self.activity = CommonContainer.shared.cloudActivity
      try? await Task.sleep(for: .seconds(10))
      self.activity = nil
    }
  }
}
