import SwiftUI
import Model

struct StationNameView {
  let station: TopTracksStation
  @Binding var isChangingName: Bool
  @State var stationName = ""
  @FocusState private var userNameFocused: Bool
  @Environment(\.editMode) private var editMode
}

extension StationNameView: View {
  var body: some View {
    if editMode?.wrappedValue.isEditing == true {
      TextField(station.name, text: $stationName)
        .font(.headline)
        .padding(.bottom, 8)
        .background(Color.black.opacity(0.4))
        .border(Color.secondary)
        .multilineTextAlignment(.center)
        .focused($userNameFocused)

      .onSubmit {
        isChangingName = false
        station.changeStationName(to: stationName)
      }
      .onAppear {
        stationName = station.stationName
      }
      .onChange(of: isChangingName) { value in
        userNameFocused = value
      }
    } else {
      Text(station.name)
        .padding(.bottom, 8)
        .multilineTextAlignment(.leading)

    }

  }
}
//
//import SwiftUI
//import Model
//
//struct StationNameView {
//  let station: TopTracksStation
//  @Binding var isChangingName: Bool
//  @State var stationName = ""
//  @FocusState private var userNameFocused: Bool
//  @Environment(\.editMode) private var editMode
//}
//
//extension StationNameView: View {
//  var body: some View {
//    if editMode?.wrappedValue.isEditing == true {
//
//    } else {
//      Text(station.name)
//        .padding(.bo)
//
//    }
//      TextField(station.name, text: $stationName)
//        .font(.headline)
//        .padding(.bottom, 8)
//        .disabled(!isChangingName)
//        .background(isChangingName ? Color.black.opacity(0.4) : Color.clear)
//        .border((isChangingName ? Color.secondary : Color.clear), width: 1)
//        .multilineTextAlignment(isChangingName ? .center : .leading)
//        .focused($userNameFocused)
//
//      .onSubmit {
//        isChangingName = false
//        station.changeStationName(to: stationName)
//      }
//      .onAppear {
//        stationName = station.stationName
//      }
//      .onChange(of: isChangingName) { value in
//        userNameFocused = value
//      }
//  }
//}
//
