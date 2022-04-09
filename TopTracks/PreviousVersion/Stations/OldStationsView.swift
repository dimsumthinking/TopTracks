//import SwiftUI
//
//struct StationsView {
//  @State private var isShowingSettings = false
//  @EnvironmentObject var topTracksStatus: TopTracksStatus
//}
//
//extension StationsView: View {
//  var body: some View {
//    NavigationView {
//      VStack {
//        StationListView()
//          .toolbar{
//            ToolbarItem(placement: .navigationBarLeading){
//              Button(action: {isShowingSettings = true}){
//                Image(systemName: "gear")
//              }
//            }
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//              EditButton()
//              Button(action: startBuilding){
//                Image(systemName: "plus")
//              }
//            }
//          }
//      }
//    }
//  }
//}
//
//extension StationsView {
//  private func startBuilding() {
//    topTracksStatus.isCreatingNew = true
//  }
//}
//
//struct StationsView_Previews: PreviewProvider {
//  static var previews: some View {
//    StationsView()
//  }
//}
