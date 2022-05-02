let playlistArtworkImageSize: Double = 80
let songPreviewArtworkImageSize: Double = 80


let playerArtworkImageSize: Double = 250

let preferredMinimumTracksForStation = 18
let preferredMaximumSongsPerRotationCategory = 12


import UIKit

let artworkPreviewImageWidth = min(UIScreen.main.bounds.width * 1 / 2, 400)
let clockImageWidth = min(UIScreen.main.bounds.width * 7 / 8, 400)

let stationTypeCellWidth = min(UIScreen.main.bounds.width * 7 / 8, 400)
let chartTypeCellWidth = min(UIScreen.main.bounds.width * 7 / 8, 400)

let stationListCellWidth = min(UIScreen.main.bounds.width * 1 / 8, 80)

let miniArtworkImageSize = min(UIScreen.main.bounds.width * 1 / 8, 80)
let fullArtworkImageSize = min(UIScreen.main.bounds.width * 1 / 2, 200)

let backButtonArtworkImageSize = min(UIScreen.main.bounds.width * 1 / 10, 40)

let fullPlayerSwipe = min(UIScreen.main.bounds.width * 1 / 2, 200)

import SwiftUI
let anchorPointForPlayerTransition = UnitPoint(x: 0.04, y: 0.98)
