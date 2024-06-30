import SwiftUI
import Model

struct CloudActivityView: View {
//  @State private var activity = CommonContainer.shared.cloudActivity
  @State private var activity: Bool = true
}

extension CloudActivityView {
  var body: some View {
    HStack {
      Spacer()
      Image(systemName: "icloud.and.arrow.down")
        .imageScale(.large)
//        .foregroundStyle(activity.isDownloading ? Color.accentColor : .clear)
        .foregroundStyle(activity ? Color.accentColor : .clear)
      Text("Checking iCloud for stations")
      ProgressView().padding()
      Spacer()
    }
    .task {
        try? await Task.sleep(for: .seconds(15))
        activity = false
    }
  }
}
