//import CarPlay
//import MusicKit
import Foundation
////import os
////import MediaPlayer
//
///// `TemplateManager` manages the CarPlay connections and templates.
class CarRadioStations: NSObject {
}
//
//    /// A reference to the CPInterfaceController that passes in after connecting to CarPlay.
//    private var carplayInterfaceController: CPInterfaceController?
//    
//    /// The CarPlay session configuation contains information on restrictions for the specified interface.
//    var sessionConfiguration: CPSessionConfiguration!
//    
//    /// The observer of the Now Playing item changes.
//    var nowPlayingItemObserver: NSObjectProtocol?
//    
//    /// The observer of the playback state changes.
//    var playbackObserver: NSObjectProtocol?
//    
//    /// The current queue of songs.
//    var currentQueue: [Song]?
//
//    // MARK: CPTemplateApplicationSceneDelegate
//    
//    /// Connects the root template to the CPInterfaceController.
//    func connect(_ interfaceController: CPInterfaceController) {
//        carplayInterfaceController = interfaceController
//        carplayInterfaceController!.delegate = self
//        sessionConfiguration = CPSessionConfiguration(delegate: self)
//        addObservers()
//        
//        AppleMusicAPIController.sharedController.prepareForRequests { [self] _ in
//            
//            /// - Tag: did_connect
//            var tabTemplates = [CPTemplate]()
//            
//            if let playlists = MediaPlayerUtilities.searchForPlaylistsInLocalLibrary(withPredicate: nil) {
//                
//                let listItems = playlists.compactMap { (playlist) -> CPListItem? in
//                    let listItem = CPListItem(text: playlist.name, detailText: "")
//                    listItem.handler = { playlistItem, completion in
//                        AppleMusicAPIController.playWithItems(items: playlist.items.compactMap({ (item) -> String? in
//                            return item.playbackStoreID
//                        }))
//                        completion()
//                    }
//                    return listItem
//                }
//                
//                var playlistTemplate: CPListTemplate!
//                
//                if #available(iOS 15.0, *) {
//                    let configuration = CPAssistantCellConfiguration(
//                                        position: .top,
//                                        visibility: .always,
//                                        assistantAction: .playMedia)
//                    playlistTemplate = CPListTemplate(
//                                        title: "Playlists",
//                                        sections: [CPListSection(items: listItems)],
//                                        assistantCellConfiguration: configuration)
//                                    
//                } else {
//                    playlistTemplate = CPListTemplate(
//                                        title: "Playlists",
//                                        sections: [CPListSection(items: listItems)])
//                                    
//                }
//                
//                playlistTemplate.tabImage = UIImage(systemName: "list.star")
//                
//                tabTemplates.append(playlistTemplate)
//            }
//            
//            tabTemplates.append(genresTemplate())
//            tabTemplates.append(settingsTemplate())
//            
//            self.carplayInterfaceController!.delegate = self
//            self.carplayInterfaceController!.setRootTemplate(CPTabBarTemplate(templates: tabTemplates), animated: true, completion: nil)
//        }
//    }
//    
//    /// Called when CarPlay disconnects.
//    func disconnect() {
//        MemoryLogger.shared.appendEvent("Disconnected from CarPlay window.")
//        nowPlayingItemObserver = nil
//        playbackObserver = nil
//        MPMusicPlayerController.applicationQueuePlayer.pause()
//    }
//
//}
//
////extension TemplateManager: CPNowPlayingTemplateObserver {
////    func nowPlayingTemplateUpNextButtonTapped(_ nowPlayingTemplate: CPNowPlayingTemplate) {
////        // Show the queue of songs.
////        if let queue = self.currentQueue {
////            CPNowPlayingTemplate.shared.isUpNextButtonEnabled = true
////            let listTemplate = CPListTemplate(title: "Playlist", sections: [CPListSection(items: queue.compactMap({ item -> CPListItem in
////                let listItem = CPListItem(text: item.attributes?.name, detailText: item.attributes?.artistName)
////                listItem.isPlaying = queue[MPMusicPlayerController.applicationQueuePlayer.indexOfNowPlayingItem].identifier == item.identifier
////                searchHandlerForItem(listItem: listItem)
////                return listItem
////            }))])
////            self.carplayInterfaceController?.pushTemplate(listTemplate, animated: true, completion: nil)
////        } else {
////            CPNowPlayingTemplate.shared.isUpNextButtonEnabled = false
////        }
////    }
////
////    func nowPlayingTemplateAlbumArtistButtonTapped(_ nowPlayingTemplate: CPNowPlayingTemplate) {
////        // If a user taps the AlbumArtistButton, a search for songs from that artist begins.
////        if let albumArtist = MPMusicPlayerController.applicationQueuePlayer.nowPlayingItem?.albumArtist {
////            AppleMusicAPIController.sharedController.searchForTerm(albumArtist) { items in
////                self.playSelectedSongs(items: items)
////            }
////        }
////    }
////}
////
////extension TemplateManager: CPInterfaceControllerDelegate {
////    func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
////        MemoryLogger.shared.appendEvent("Template \(aTemplate.classForCoder) will appear.")
////    }
////
////    func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {
////        MemoryLogger.shared.appendEvent("Template \(aTemplate.classForCoder) did appear.")
////    }
////
////    func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {
////        MemoryLogger.shared.appendEvent("Template \(aTemplate.classForCoder) will disappear.")
////    }
////
////    func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {
////        MemoryLogger.shared.appendEvent("Template \(aTemplate.classForCoder) did disappear.")
////    }
////}
////
////extension TemplateManager: CPSessionConfigurationDelegate {
////    func sessionConfiguration(_ sessionConfiguration: CPSessionConfiguration,
////                              limitedUserInterfacesChanged limitedUserInterfaces: CPLimitableUserInterface) {
////        MemoryLogger.shared.appendEvent("Limited UI changed: \(limitedUserInterfaces)")
////    }
////}
////
////extension TemplateManager {
////
////    /// Starts a search with the title of the list item.
////    func searchHandlerForItem(listItem: CPListItem) {
////        listItem.handler = { item, completion in
////            AppleMusicAPIController.sharedController.searchForTerm(item.text!) { items in
////                self.playSelectedSongs(items: items)
////                completion()
////            }
////        }
////    }
////
////    /// Maps and plays the selected Song objects.
////    func playSelectedSongs(items: [Song]?) {
////        if let items = items {
////            self.currentQueue = items
////            MemoryLogger.shared.appendEvent("Song count \(items.count).")
////            AppleMusicAPIController.playWithItems(items: items.compactMap({ (song) -> String in
////                return song.identifier
////            }))
////        } else {
////            MemoryLogger.shared.appendEvent("Song count 0.")
////        }
////    }
////
////    /// Add observers for playback and Now Playing item.
////    private func addObservers() {
////        CPNowPlayingTemplate.shared.add(self)
////        /// - Tag: observe
////        self.playbackObserver = NotificationCenter.default.addObserver(
////            forName: .MPMusicPlayerControllerPlaybackStateDidChange,
////            object: nil,
////            queue: .main) {
////            notification in
////            MemoryLogger.shared.appendEvent(
////                "MPMusicPlayerControllerPlaybackStateDidChange: \(MPMusicPlayerController.applicationQueuePlayer.playbackState)")
////        }
////
////        self.nowPlayingItemObserver = NotificationCenter.default.addObserver(
////            forName: .MPMusicPlayerControllerNowPlayingItemDidChange,
////            object: nil,
////            queue: .main) {
////            notification in
////            MemoryLogger.shared.appendEvent("MPMusicPlayerControllerNowPlayingItemDidChange")
////        }
////    }
////
////    /// Creates the handler to play music for the selected CPListItem.
////    private func createPlayerHandler(item: CPListItem) {
////        item.handler = { item, completion in
////            AppleMusicAPIController.sharedController.searchForTerm(item.text!) { items in
////                self.playSelectedSongs(items: items)
////                completion()
////            }
////        }
////    }
////
////    /// Creates a playlist from an array of Chart objects.
////    private func createListFromCharts(charts: [Chart]) {
////        self.carplayInterfaceController?.pushTemplate(
////            CPListTemplate(
////                title: "Genres",
////                sections: [CPListSection(items: charts.compactMap({ (chart) -> CPListItem? in
////                    let item = CPListItem(text: chart.name, detailText: "")
////                    searchHandlerForItem(listItem: item)
////                    return item
////                }))]),
////            animated: true,
////            completion: nil)
////    }
////
////    /// Creates the settings CPListTemplate.
////    private func settingsTemplate() -> CPListTemplate {
////        let musicItem = CPListItem(text: "Use Apple Music", detailText: "Decide whether to enable it.")
////        musicItem.handler = { listItem, completion in
////            let item: CPGridButton!
////            if AppleMusicAPIController.sharedController.useAppleMusic == true {
////                item = CPGridButton(titleVariants: ["Enabled, tap to disable."], image: #imageLiteral(resourceName: "dot_green"), handler: { (button) in
////                    AppleMusicAPIController.sharedController.useAppleMusic = false
////                    self.carplayInterfaceController?.popTemplate(animated: true, completion: nil)
////                })
////            } else {
////                item = CPGridButton(titleVariants: ["Disabled, tap to enable."], image: #imageLiteral(resourceName: "dot_red"), handler: { (button) in
////                    AppleMusicAPIController.sharedController.useAppleMusic = true
////                    self.carplayInterfaceController?.popTemplate(animated: true, completion: nil)
////                })
////            }
////            self.carplayInterfaceController?.pushTemplate(
////                CPGridTemplate(title: "Apple Music", gridButtons: [item]), animated: true, completion: nil)
////            completion()
////        }
////        let musicSection = CPListSection(items: [musicItem], header: "Music", sectionIndexTitle: "Apple Music")
////
////        let contentItem = CPListItem(text: "Allow Explicit Content", detailText: "Decide whether to enable it.")
////        contentItem.handler = { listItem, completion in
////            let item: CPGridButton!
////            if AppleMusicAPIController.sharedController.allowExplicitContent == true {
////                item = CPGridButton(titleVariants: ["Enabled, tap to disable."], image: #imageLiteral(resourceName: "dot_green"), handler: { (button) in
////                    AppleMusicAPIController.sharedController.allowExplicitContent = false
////                    self.carplayInterfaceController?.popTemplate(animated: true, completion: nil)
////                })
////            } else {
////                item = CPGridButton(titleVariants: ["Disabled, tap to enable."], image: #imageLiteral(resourceName: "dot_red"), handler: { (button) in
////                    AppleMusicAPIController.sharedController.allowExplicitContent = true
////                    self.carplayInterfaceController?.popTemplate(animated: true, completion: nil)
////                })
////            }
////            self.carplayInterfaceController?.pushTemplate(
////                CPGridTemplate(title: "Music Content", gridButtons: [item]), animated: true, completion: nil)
////            completion()
////        }
////        let contentSection = CPListSection(items: [contentItem], header: "Content", sectionIndexTitle: "Music Content")
////
////        let template = CPListTemplate(title: "Settings", sections: [musicSection, contentSection])
////        template.tabImage = UIImage(systemName: "gear")
////        return template
////    }
////
////    /// Creates the genre's CPListTemplate.
////    private func genresTemplate() -> CPListTemplate {
////        let reggae = CPListItem(text: "Reggae", detailText: "Relax and feel good.")
////        reggae.setImage(UIImage(systemName: "sun.max")!)
////        searchHandlerForItem(listItem: reggae)
////
////        let jazz = CPListItem(text: "Jazz", detailText: "How about some smooth jazz.")
////        jazz.setImage(UIImage(systemName: "music.note.house")!)
////        searchHandlerForItem(listItem: jazz)
////
////        let alternative = CPListItem(text: "Alternative", detailText: "Catch a vibe.")
////        alternative.setImage(UIImage(systemName: "guitars.fill")!)
////        searchHandlerForItem(listItem: alternative)
////
////        let hipHop = CPListItem(text: "Hip-Hop", detailText: "Play the latest jams.")
////        hipHop.setImage(UIImage(systemName: "music.mic")!)
////        searchHandlerForItem(listItem: hipHop)
////
////        let songCharts = CPListItem(text: "Check the Top Song Charts", detailText: "See what's trending.")
////        songCharts.setImage(UIImage(systemName: "chart.bar.fill")!)
////        songCharts.handler = { item, completion in
////            AppleMusicAPIController.sharedController.searchSongCharts(completion: { items in
////                if let items = items {
////                    MemoryLogger.shared.appendEvent("Chart count \(items.count).")
////                    if items.count > 1 {
////                        self.createListFromCharts(charts: items)
////                    } else if let firstSet = items.first?.data {
////                        self.currentQueue = firstSet
////                        AppleMusicAPIController.playWithItems(items: firstSet.compactMap({ (song) -> String in
////                            return song.identifier
////                        }))
////                    }
////                } else {
////                    MemoryLogger.shared.appendEvent("Song count 0.")
////                }
////                completion()
////            })
////        }
////        let template = CPListTemplate(title: "Genres", sections: [CPListSection(items: [reggae, jazz, alternative, hipHop, songCharts])])
////        template.tabImage = UIImage(systemName: "music.note.list")
////        return template
////    }
////
////}
////
