#if !os(macOS)
import SwiftUI
import UIKit
import AVKit


struct RoutePicker: UIViewRepresentable {
  typealias UIViewType = AVRoutePickerView

  func makeUIView(context: Context) -> AVRoutePickerView {
    let routePicker = AVRoutePickerView()
    routePicker.prioritizesVideoDevices = false
    return routePicker
  }
  
  func updateUIView(_ uiView: AVRoutePickerView, context: Context) {}
}

#endif
