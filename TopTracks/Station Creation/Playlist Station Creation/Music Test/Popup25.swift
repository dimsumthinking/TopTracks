import SwiftUI

struct Popup25 {
  let next: () -> Void
  @Binding var show25Alert: Bool
  @Binding var moveOn: Bool
}

extension Popup25: View {
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "25.square")
        .font(.largeTitle)
        .padding()
      Text("You've rated twenty-five songs.")
      
      HStack {
        Image(systemName: "octagon")
          .font(.largeTitle)
          .padding()
        Spacer()
        Text("Stop now and create a mini-station where fewer songs repeat more frequently.")
          .multilineTextAlignment(.leading)
          .padding()
        Spacer()
      }
      .frame(width: chartTypeCellWidth)
      .border(.secondary)
      .contentShape(Rectangle())
      .onTapGesture(perform: stop)
      
      HStack {
        Image(systemName: "goforward")
          .font(.largeTitle)
          .padding()
        Spacer()
        Text("Keep going.")
          .multilineTextAlignment(.center)
          .padding()
          .padding(.vertical)
        Spacer()
      }
      .frame(width: chartTypeCellWidth)
      .border(.secondary)
      .contentShape(Rectangle())
      .onTapGesture(perform: nextSong)
    }
  }
}

extension Popup25 {
  private func nextSong() {
    show25Alert = false
    next()
  }
  
  private func stop() {
    show25Alert = false
    moveOn = true
  }
}

//struct Popup10_Previews: PreviewProvider {
//  static var previews: some View {
//    Popup10()
//  }
//}
