import SwiftUI
import Model

struct CloudActivityView {
  @State private var activity = CommonContainer.shared.cloudActivity
}

extension CloudActivityView: View {
  var body: some View {
    HStack {
      Spacer()
      Image(systemName: "icloud.and.arrow.down")
        .imageScale(.large)
        .foregroundStyle(activity.isDownloading ? Color.accentColor : .clear)
      Text("Checking iCloud for stations")
      ProgressView().padding()
      Spacer()
    }
  }
}
