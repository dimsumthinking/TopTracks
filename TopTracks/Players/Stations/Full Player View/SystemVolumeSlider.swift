import SwiftUI
import MediaPlayer
import UIKit

struct SystemVolumeSlider: UIViewRepresentable {
  func updateUIView(_ uiView: UIViewType, context: Context) {
  }
  
  func makeUIView(context: Context) -> some UIView {
    MPVolumeView(frame: .zero)
  }
}
