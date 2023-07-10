import SwiftUI
import Model

struct AddAPlaylist {
  
}

extension AddAPlaylist: View {
  var body: some View {
    
    VStack(alignment: .leading, spacing: 20) {
//      HStack {
//        Image(systemName: "plus")
//          .foregroundColor(.accentColor)
        Text("Tap the \(Image(systemName: "plus"))  button in the top right corner to select a playlist.")
//      }
      .padding()
      Text("Songs will be split into these categories:")
        .padding()
      Grid (verticalSpacing: 10) {
        GridRow {
          Text("Category")
          Text("Repeats")
          Text("#/hour")
        }
        GridRow {
          Divider().gridCellColumns(3)
        }
        ForEach (stationStandardCategories) { category in
          GridRow {
            HStack {
              Image(systemName: category.icon)
              Text(category.description)
            }
            .gridColumnAlignment(.leading)
            Text(category.frequency)
            Text(category.numberPerHour.description)
          }
          .foregroundColor(category.color)
        }
        GridRow {
          Divider()
        }
      }
//      ForEach(stationStandardCategories) { category in
//        HStack {
//          Image(systemName: category.icon)
//            .foregroundColor(category.color)
//          Text (category.description)
//            .foregroundColor(category.color)
//          Text("repeats  ~ \(category.frequency)")
//        }
//      }
      VStack(alignment: .leading) {
        Text("< 50 songs: no Gold songs.").padding(.bottom)
        Text("> 40 songs: 10 songs in each of the top four categories.")
      }
      .font(.caption)
      .foregroundColor(.secondary)
      .padding(.horizontal)
    }
    .padding()
    .font(.headline)
    
    .navigationTitle("Info - Add a Playlist")
  }
}