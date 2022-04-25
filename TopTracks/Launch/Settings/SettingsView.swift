import SwiftUI

struct SettingsView {
  @Binding var isShowingSettings: Bool
  @AppStorage("showDataWarning") private var showDataWarning = true
  @AppStorage("hasAppSubscription") private var hasAppSubscription = false
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension SettingsView: View {
  var body: some View {
    NavigationView {
      List {
        Section("Cellular Data") {
          Button("Turn Cellular Data On/Off",
                 action: goToSettings)
          Toggle("Show Data Usage Warning",
                 isOn: $showDataWarning)
        }
        Section("Top Tracks Subscription") {
          Text("During testing toggle subscription below")
          Toggle("Subscribe",
                 isOn: $hasAppSubscription)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Settings")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing){
          Button("Done"){isShowingSettings = false}
        }
      }
    }
  }
}

extension SettingsView {
  private func goToSettings() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(isShowingSettings: .constant(true))
  }
}