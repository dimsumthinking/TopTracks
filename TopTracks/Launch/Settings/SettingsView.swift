import SwiftUI

struct SettingsView {
  @Binding var isShowingSettings: Bool
  @Binding var isShowingAppSubscriptions: Bool
  @AppStorage("showDataWarning") private var showDataWarning = true
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
        Section("Subscription Info") {
          Text("\(topTracksStatus.activeAppSubscriptionType.description) subscription active")
          if let expirationDate = topTracksStatus.activeAppExpirationDate,
              let expirationDateAsString = dateFormatter.string(from: expirationDate),
            topTracksStatus.activeAppSubscriptionType != .none {
            Text("Renews: \(expirationDateAsString)")
          }
          Button("Go to subscriptions",
                 action: {
            isShowingSettings = false
            isShowingAppSubscriptions = true
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Settings")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing){
          Button("Done"){
            isShowingSettings = false
          }
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
    SettingsView(isShowingSettings: .constant(true),
                 isShowingAppSubscriptions: .constant(false))
  }
}

fileprivate let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .none
  return formatter
}()
