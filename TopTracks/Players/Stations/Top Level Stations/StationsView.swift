import SwiftUI

struct StationsView {
  @State private var isShowingSettings = false
  @EnvironmentObject var topTracksStatus: TopTracksStatus
  @AppStorage("hasAppSubscription") private var hasAppSubscription = false
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @State private var isShowingReachedLimitAlert = false
}

extension StationsView: View {
  var body: some View {
    NavigationView {
      VStack {
        StationListView()
          .sheet(isPresented: $isShowingSettings){
            SettingsView(isShowingSettings: $isShowingSettings)
          }
          .alert("You need to subscribe\nto create more than\nthree stations\n\nTesters - you can toggle\nthis in Settings",
                 isPresented: $isShowingReachedLimitAlert){
            Button("OK"){isShowingReachedLimitAlert = false}
          }
          .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
              Button(action: {isShowingSettings = true}){
                Image(systemName: "gear")
              }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
              EditButton()
              Button(action: startBuilding){
                Image(systemName: "plus")
              }
            }
          }
      }
    }
  }
}

extension StationsView {
  private func startBuilding() {
    if stations.count > 2 && hasAppSubscription == false {
      isShowingReachedLimitAlert = true
    } else {
    topTracksStatus.isCreatingNew = true
    }
  }
}

struct StationsView_Previews: PreviewProvider {
  static var previews: some View {
    StationsView()
  }
}
