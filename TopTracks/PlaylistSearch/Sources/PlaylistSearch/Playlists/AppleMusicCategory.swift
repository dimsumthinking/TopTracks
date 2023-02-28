import Foundation

//let appleMusicCategories = AppleMusicCategory.allCases
//let defaultMusicCategory = AppleMusicCategory.spatialAudio
//let appleMusicSpatial = AppleMusicCategory.spatialAudio
//let appleMusicEssentials = AppleMusicCategory.essentials
//let appleMusicDecades: [AppleMusicCategory]
//= [.oldies, .fifties, .sixties, .seventies, .eighties, .nineties, .twoThousands, .twentyTens]//, .twentyTwenties]
//let appleMusicGenres: [AppleMusicCategory]
//= [.spatialAudio, .essentials, .acoustic, .african, .alternative, .americana, .behindTheSongs, .blues, .christian,
//   .classicRock, .classical, .country, .cPop, .dance, .devotional, .djMixes, .electronic, .family,
//   .filmTVStage, .gospel, .hardRock, .hits, .hipHop, .holiday, .indie, .jazz,
//   .kPop, .kids, .latin, .live, .metal, .musicaMexicana, .musicaTropical, .pop, .pride, .punk,
//   .radio, .rAndB, .reggae, .rock, .rockYAlternativo, .samba, .soulFunk, .upNext, .urbanoLatino]
//
//let appleMusicWorldwide: [AppleMusicCategory]
//= [.african, .afrikaans, .anime, .arabic, .baileFunk, .bollywood, .brazilianPop, .cPop,
//   .canadian, .cantopop,  .catalana, .deutschpop, .deutschrap, .devotional, .firstNationsAustralia,
//   .flamenco, .frenchPop, .frenchRap, .halk, .horspiele, .indianIndependent, .indonesianMusic,
//   .islamic, .jHipHop, .jPop, .jRock, .japan, .kPop, .kannada, .malayalam, .malaysianMusic,
//   .mandopop, .mizrahi, .mpb, .musicaMexicana, .musicaTropical, .musiqueFrancophone, .pilipino,
//   .popItaliano, .popLatino, .punjabi, .religiKetuhanan, .rockInSpanish, .rockYAlternativo,
//   .russian, .russianHipHop, .russianPop, .russianRock, .sanat, .schlager, .sertanejo,
//   .tamil, .telugu, .thaiMusic, .valienato, .worldwide]
//
//let appleMusicMoodsAndActivities: [AppleMusicCategory]
//= [ .afterHours, .aloneTime, .chill, .commuting, .eatingAndCooking, .evening,
//    .feelGood, .feelingBlue, .fitness, .focus, .gaming, .heartbreak, .home,
//    .morning, .motivation, .outdoors, .party, .romance, .sleep, .social, .sports, .summertimeSounds,
//    .vacation, .weekend, .wellbeing, .work ]

enum AppleMusicCategory: String, CaseIterable {
  // Spatial
  case spatialAudio = "Spatial Audio"
  
  // Essentials
  case essentials

  
  // Decades
  case decades
  case oldies
  case fifties = "50s"
  case sixties = "60s"
  case seventies = "70s"
  case eighties = "80s"
  case nineties = "90s"
  case twoThousands = "2000s"
  case twentyTens = "2010s"
//  case twentyTwenties = "2020s"
  
  // Genre
  case acoustic
  case african = "African Music"
  case alternative
  case americana
  case behindTheSongs = "Behind the Songs"
  case blues
  case christian
  case classicRock = "Classic Rock"
  case classical
  case country
  case cPop = "C-Pop"
  case dance
  case devotional
  case djMixes = "DJ Mixes"
  case electronic
  case family
  case filmTVStage = "Film, TV & Stage"
  case gospel
  case hardRock = "Hard Rock"
  case hits
  case hipHop = "Hip-Hop"
  case holiday
  case indie
  case jazz
  case kPop = "K-Pop"
  case kids
  case latin
  case live
  case metal
  case musicaMexicana = "Música Mexicana"
  case musicaTropical = "Música Tropical"
  case pop
  case pride
  case punk
  case radio
  case rAndB = "R&B"
  case reggae
  case rock
  case rockYAlternativo = "Rock y Alternativo"
  case samba
  case soulFunk = "Soul/Funk"
  case upNext = "Up Next"
  case urbanoLatino = "Urbano Latino"

  // Worldwide (not listed above)
  case afrikaans
  case anime
  case arabic
  case baileFunk = "Baile Funk"
  case bollywood
  case brazilianPop = "Brazilian Pop"
  case canadian
  case cantopop
  case catalana
  case deutschpop
  case deutschrap
  case firstNationsAustralia = "First Nations Australia"
  case flamenco
  case frenchPop = "French Pop"
  case frenchRap = "French Rap"
  case halk
  case horspiele = "Hörspiele"
  case indianIndependent = "Indian Independent"
  case indonesianMusic = "Indonesian Music"
  case islamic
  case jHipHop = "J-Hip-Hop"
  case jPop = "J-Pop"
  case jRock = "J-Rock"
  case japan
  case kannada
  case kayokyoku
  case malayalam
  case malaysianMusic = "Malaysian Music"
  case mandopop
  case mizrahi
  case mpb = "MPB"
  case musiqueFrancophone = "Musique francophone"
  case pilipino
  case popItaliano = "Pop Italiano"
  case popLatino = "Pop Latino"
  case punjabi
  case rapItaliano = "Rap Italiano"
  case religiKetuhanan = "Religi/Ketuhanan"
  case rockInSpanish = "Rock in Spanish"
  case russian
  case russianHipHop = "Russian Hip-Hop"
  case russianPop = "Russian Pop"
  case russianRock = "Russian Rock"
  case sanat
  case schlager
  case sertanejo
  case tamil
  case telugu
  case thaiMusic = "Thai Music"
  case valienato
  case worldwide

  // Moods and Activities
  
  case afterHours = "After Hours"
  case aloneTime = "Alone Time"
  case chill
  case commuting
  case eatingAndCooking = "Eating and Cooking"
  case evening
  case feelGood = "Feel Good"
  case feelingBlue = "Feeling Blue"
  case fitness
  case focus
  case gaming
  case heartbreak
  case home
  case morning
  case motivation
  case outdoors
  case party
  case romance
  case sleep
  case social
  case sports
  case summertimeSounds = "Summertime Sounds"
  case vacation
  case weekend
  case wellbeing
  case work
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

extension AppleMusicCategory {
  static let appleMusicCategories = AppleMusicCategory.allCases
  static let defaultMusicCategory = AppleMusicCategory.spatialAudio
  static let appleMusicSpatial = AppleMusicCategory.spatialAudio
  static let appleMusicEssentials = AppleMusicCategory.essentials
  static let appleMusicDecades: [AppleMusicCategory]
  = [.oldies, .fifties, .sixties, .seventies, .eighties, .nineties, .twoThousands, .twentyTens]//, .twentyTwenties]
  static let appleMusicGenres: [AppleMusicCategory]
  = [.spatialAudio, .essentials, .acoustic, .african, .alternative, .americana, .behindTheSongs, .blues, .christian,
     .classicRock, .classical, .country, .cPop, .dance, .devotional, .djMixes, .electronic, .family,
     .filmTVStage, .gospel, .hardRock, .hits, .hipHop, .holiday, .indie, .jazz,
     .kPop, .kids, .latin, .live, .metal, .musicaMexicana, .musicaTropical, .pop, .pride, .punk,
     .radio, .rAndB, .reggae, .rock, .rockYAlternativo, .samba, .soulFunk, .upNext, .urbanoLatino]

  static let appleMusicWorldwide: [AppleMusicCategory]
  = [.african, .afrikaans, .anime, .arabic, .baileFunk, .bollywood, .brazilianPop, .cPop,
     .canadian, .cantopop,  .catalana, .deutschpop, .deutschrap, .devotional, .firstNationsAustralia,
     .flamenco, .frenchPop, .frenchRap, .halk, .horspiele, .indianIndependent, .indonesianMusic,
     .islamic, .jHipHop, .jPop, .jRock, .japan, .kPop, .kannada, .malayalam, .malaysianMusic,
     .mandopop, .mizrahi, .mpb, .musicaMexicana, .musicaTropical, .musiqueFrancophone, .pilipino,
     .popItaliano, .popLatino, .punjabi, .religiKetuhanan, .rockInSpanish, .rockYAlternativo,
     .russian, .russianHipHop, .russianPop, .russianRock, .sanat, .schlager, .sertanejo,
     .tamil, .telugu, .thaiMusic, .valienato, .worldwide]

  static let appleMusicMoodsAndActivities: [AppleMusicCategory]
  = [ .afterHours, .aloneTime, .chill, .commuting, .eatingAndCooking, .evening,
      .feelGood, .feelingBlue, .fitness, .focus, .gaming, .heartbreak, .home,
      .morning, .motivation, .outdoors, .party, .romance, .sleep, .social, .sports, .summertimeSounds,
      .vacation, .weekend, .wellbeing, .work ]
}
