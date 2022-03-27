import Foundation

let appleMusicCategories = AppleMusicCategory.allCases
let defaultMusicCategory = AppleMusicCategory.spatialAudio
let appleMusicDecades: [AppleMusicCategory]
= [.fifties, .sixties, .seventies, .eighties, .nineties, .twoThousands, .twentyTens, .twentyTwenties]

enum AppleMusicCategory: String, CaseIterable {
  case fifties = "'50s"
  case sixties = "`60s"
  case seventies = "`70s"
  case eighties = "`80s"
  case nineties = "`90s"
  case twoThousands = "'2000s"
  case twentyTens = "`2010s"
  case twentyTwenties = "`2020s"
  case acoustic
  case african = "African Music"
  case afrikaans
  case afterHours = "After Hours"
  case aloneTime = "Alone Time"
  case alternative
  case americana
  case anime
  case arabic
  case baileFunk = "Baile Funk"
  case behindTheSongs = "Behind the Songs"
  case blues
  case bollywood
  case brazilianPop = "Brazilian Pop"
  case cPop = "C-Pop"
  case canadian = "Canadian Music"
  case cantopop
  case chill
  case christian
  case classicRock = "Classic Rock"
  case classical
  case commuting
  case country
  case dance
  case decades
  case deutschpop
  case deutschrap
  case devotional
  case djMixes = "DJ Mixes"
  case eatingAndCooking = "Eating and Cooking"
  case electronic
  case essentials
  case evening
  case family
  case feelGood = "Feel Good"
  case feelingBlue = "Feeling Blue"
  case filmTVStage = "Film, TV & Stage"
  case fitness
  case flamenco
  case focus
  case frenchPop = "French Pop"
  case frenchRap = "French Rap"
  case gaming
  case gospel
  case turkishFolkMusic = "Turkish Folk Music"
  case hardRock = "Hard Rock"
  case heartbreak
  case hipHopRap = "Hip-Hop/Rap"
  case hits
  case holiday
  case home
  case horspiele = "Hörspiele"
  case indianIndependent = "Indian Independent"
  case indie
  case firstNationsAustralia = "First Nations Australia"
  case indonesianMusic = "Indonesian Music"
  case islamicMusic = "Islamic Music"
  case jHipHop = "J-Hip-Hop"
  case jPop = "J-Pop"
  case jRock = "J-Rock"
  case japan
  case jazz
  case kPop = "K-Pop"
  case kannada
  case kayokyoku
  case kids
  case latin
  case live
  case malayalam
  case malaysianMusic = "Malaysian Music"
  case mandopop
  case metal
  case mizrahiMusic = "Mizrahi Music"
  case morning
  case motivation
  case mpb = "MPB"
  case musicaMexicana = "Música Mexicana"
  case musicaTropical = "Música Tropical"
  case musiqueFrancophone = "Musique francophone"
  case oldies
  case originalPhilipinoMusic = "Original Philipino Music"
  case outdoors
  case party
  case pop
  case popInSpanish = "Pop in Spanish"
  case popItaliano = "Pop Italiano"
  case popLatino = "Pop Latino"
  case pride
  case punjabi
  case rAndB = "R&B"
  case reggae
  case religiKetuhanan = "Religi/Ketuhanan"
  case rock
  case rockInSpanish = "Rock in Spanish"
  case rockYAlternative = "Rock y Alternative"
  case romance
  case russian
  case russianHipHop = "Russian Hip-Hop"
  case russianPop = "Russian Pop"
  case russianRock = "Russian Rock"
  case samba
  case sanat
  case schlager
  case sertanejo
  case sleep
  case social
  case soulFunk = "Soul/Funk"
  case spatialAudio = "Spatial Audio"
  case sports
  case summertimeSounds = "Summertime Sounds"
  case tamil
  case telugu
  case thaiMusic = "Thai Music"
  case upNext = "Up Next"
  case urbanoLatino = "Urbano Latino"
  case vacation
  case valienato
  case weekend
  case wellness
  case work
  case worldwide
}

extension AppleMusicCategory: Identifiable {
  var id: Self {
    self
  }
}

extension AppleMusicCategory: CustomStringConvertible {
  var description: String {
    rawValue.first!.isLetter ? rawValue.capitalized : rawValue
    
  }
}
