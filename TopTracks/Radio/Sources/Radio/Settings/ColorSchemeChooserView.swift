import SwiftUI
import ApplicationState

struct ColorSchemeChooserView: View {
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
  @State private var index = 0
}

extension ColorSchemeChooserView {
  var body: some View {
    Section("Choose Application Color Scheme") {
      VStack {
        Picker("Color Scheme Picker", selection: $index) {
          ForEach(CurrentColorScheme.allCases) { colorScheme in
            Text(colorScheme.rawValue.capitalized).tag(colorScheme)
          }
        }
        .onChange(of: index) { oldIndex, newIndex in
          colorSchemeString = CurrentColorScheme.allCases[newIndex].rawValue
        }
        .pickerStyle(.segmented)
        .padding()
      }
    }
    .onAppear {
      index = indexForColorScheme(from: colorSchemeString)
    }
  }
}

