import SwiftUI
import Model

struct CloudActivityView: View {
//  @State private var activity: CloudActivity?
  @State private var activity: Bool = true
}

extension CloudActivityView {
  var body: some View {
    HStack {
      Spacer()
//      if let _ = self.activity {
      if activity {
        Image(systemName: "icloud.and.arrow.down")
          .imageScale(.large)
        Text("Checking iCloud for stations")
        ProgressView().padding()
      }
      Spacer()
    }
    .task {
//      self.activity = await CommonContainer.shared.cloudActivity
      try? await Task.sleep(for: .seconds(10))
      self.activity = false
    }
  }
}
