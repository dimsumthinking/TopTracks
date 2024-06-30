import SwiftUI
import Model

struct StationNameView: View {
  let station: TopTracksStation
  @Binding var isChangingName: Bool
  @State var stationName = ""
  @FocusState private var userNameFocused: Bool
  @Environment(\.editMode) private var editMode
}

extension StationNameView {
  @ViewBuilder
  var body: some View {
    if editMode?.wrappedValue.isEditing == true {
      TextField(station.name, text: $stationName)
        .font(.headline)
        .background(Color.black.opacity(0.4))
        .border(Color.secondary)
        .multilineTextAlignment(.center)
        .focused($userNameFocused)

      .onSubmit {
        isChangingName = false
        station.stationName = stationName
      }
      .onAppear {
        stationName = station.stationName
      }
      .onChange(of: isChangingName) { oldValue, newValue in
        userNameFocused = newValue
      }
    } else {
      Text(station.name)
        .padding(.bottom, 8)
        .multilineTextAlignment(.leading)
        .lineLimit(3)

    }

  }
}
