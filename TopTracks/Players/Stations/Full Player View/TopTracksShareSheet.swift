import SwiftUI
import UIKit
import LinkPresentation
import MusicKit


struct TopTracksShareSheet: UIViewControllerRepresentable {
  let song: Song
  let station: TopTracksStation
  
  
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<TopTracksShareSheet>) ->  UIActivityViewController {
//    let activityController = UIActivityViewController(activityItems: [image, songInfo + directions , url],
//                             applicationActivities: nil)
    
    let activityController = UIActivityViewController(activityItems: [songInfo + directions, url, TopTracksShareSheetItemSource(self), ],
                             applicationActivities: nil)
    activityController.excludedActivityTypes = [.addToReadingList, .assignToContact, .copyToPasteboard, .markupAsPDF, .openInIBooks, .postToFlickr, .postToVimeo, .print,.saveToCameraRoll, .sharePlay]
    return activityController

  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController,
                          context:  UIViewControllerRepresentableContext<TopTracksShareSheet>) {
  }
   var songInfo: String {
    "I'm listening to " + song.title + " by " + song.artistName +  "\n\n"
  }
  var stationInfo: String {
    "Sharing \(station.stationName)"
  }
  
  private var directions: String {
    "Use this link to add " + station.stationName + " to your Top Tracks stations:\n\n"
  }
  
   var url: URL {
    station.url ?? URL(string: "https://dimsumthinking.com/Apps/TopTracks/")!
  }
  
  private var image: UIImage {
    UIImage(named: "AppIcon") ?? UIImage(systemName: "music.mic")!
  }
}

class TopTracksShareSheetItemSource: NSObject, UIActivityItemSource {
  let shareSheet:TopTracksShareSheet
  
  init(_ shareSheet: TopTracksShareSheet) {
    self.shareSheet = shareSheet
  }
  
  func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
    UIImage(named: "AppIcon")!
  }
  
  func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
    Bundle.main.path(forResource: "AppIcon", ofType: "png").map{URL(fileURLWithPath: $0)}
  }
  
  func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
    let urlOfImageToShare = Bundle.main.path(forResource: "AppIcon", ofType: "png").map{URL(fileURLWithPath: $0)}
    let metadata = LPLinkMetadata()
    
    metadata.title = shareSheet.stationInfo// Preview Title
    metadata.originalURL = URL(string: "https://dimsumthinking.com/Apps/TopTracks/")! // determines the Preview Subtitle
    metadata.url = shareSheet.url
    
    metadata.imageProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
    metadata.iconProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
    
    return metadata
  }
  
}
