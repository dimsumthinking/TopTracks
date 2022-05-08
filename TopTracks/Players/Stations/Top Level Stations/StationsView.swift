import SwiftUI

struct StationsView {
  @State private var isShowingSettings = false
  @State private var isShowingAppSubscriptions = false
  @EnvironmentObject var topTracksStatus: TopTracksStatus
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
            SettingsView(isShowingSettings: $isShowingSettings,
            isShowingAppSubscriptions: $isShowingAppSubscriptions)
          }
          .sheet(isPresented: $isShowingAppSubscriptions){
            AppSubscriptionView(isShowingAppSubscriptions: $isShowingAppSubscriptions)
          }
          .alert("You need an active subscription to create more than three stations",
                 isPresented: $isShowingReachedLimitAlert){
            VStack {
              Button("Subscriptions"){
                isShowingReachedLimitAlert = false
                isShowingAppSubscriptions = true
              }
              Button("Dismiss") 
              {isShowingReachedLimitAlert = false}
            }
          }
          .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
              Button(action: {isShowingSettings = true}){
                Image(systemName: "gear")
              }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
//              EditButton()
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
    if stations.count > 2 && topTracksStatus.hasAppSubscription == false {
      isShowingReachedLimitAlert = true
    } else {
      topTracksStatus.startCreating()
    }
  }
}

struct StationsView_Previews: PreviewProvider {
  static var previews: some View {
    StationsView()
  }
}
