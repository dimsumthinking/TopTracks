import SwiftUI
import ApplicationState

struct ColorSchemeChooserView {
  @AppStorage("colorScheme") private var colorSchemeString = "dark"
  @State private var index = 0
}

extension ColorSchemeChooserView: View {
  var body: some View {
    Section("Choose Application Color Scheme") {
      VStack {
        Picker("Color Scheme Picker",
               selection: $index) {
          ForEach(CurrentColorScheme.allCases) { colorScheme in
            Text(colorScheme.rawValue.capitalized).tag(colorScheme)
          }
        }
               .onChange(of: index) { oldValue, newValue in
                 colorSchemeString = CurrentColorScheme.allCases[newValue].rawValue
               }
               .pickerStyle(.segmented)
               .padding()
      }
    }
    .onAppear {
      index = indexForColorScheme(from: colorSchemeString)
    }
//    .preferredColorScheme(currentColorScheme(from:  colorSchemeString))
  }
}

