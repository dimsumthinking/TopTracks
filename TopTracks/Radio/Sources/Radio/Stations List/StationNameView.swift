import SwiftUI
import Model

struct StationNameView {
  let station: TopTracksStation
  @Binding var isChangingName: Bool
  @State var stationName = ""
  @FocusState private var userNameFocused: Bool
}

extension StationNameView: View {
  var body: some View {
    ZStack {
      TextField(station.name, text: $stationName)
        .font(.headline)
        .padding(.bottom, 8)
        .disabled(!isChangingName)
        .background(isChangingName ? Color.black : Color.clear)
        .border((isChangingName ? Color.secondary : Color.clear), width: 3)
        .multilineTextAlignment(isChangingName ? .center : .leading)
        .focused($userNameFocused)
      if isChangingName {
        HStack (alignment: .center) {
          Spacer()
          Button {
            isChangingName = false
            station.changeStationName(to: stationName)
          } label: {
            Image(systemName: "arrow.turn.down.left")
          }
          .buttonStyle(.bordered)
          .tint(.secondary)
          .padding(.trailing)
        }
      }
    }
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
  }
}

