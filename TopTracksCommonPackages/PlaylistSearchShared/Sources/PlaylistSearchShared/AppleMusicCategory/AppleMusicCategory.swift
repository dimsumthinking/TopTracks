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

public enum AppleMusicCategory: String, CaseIterable, Sendable {
  // Spatial
  case spatialAudio = "Spatial Audio"
  
  // Essentials
  case essentials
  
  // Coming Soon
  case comingSoon = "Coming Soon"
  
  
  // Charts
  case charts

  
  // Decades
  case decades
  case oldies
  case twenties = "20s"
  case thirties = "30s"
  case forties = "40s"
  case fifties = "50s"
  case sixties = "'60s"
  case seventies = "'70s"
  case eighties = "'80s"
  case nineties = "'90s"
  case twoThousands = "2000s"
  case twentyTens = "2010s"
//  case twentyTwenties = "2020s"
  
  // Genre
  case acoustic
  case afrobeats
  case alternative
  case americana
  case anime
  case appleMusicRadio = "Apple Music Radio"
  case behindTheSongs = "Behind the Songs"
  case blues
  case christian
  case classicRock = "Classic Rock"
  case classical
  case country
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
  case kids
  case live = "Live Music"
  case metal
  case pop
  case pride
  case punk
  case radio
  case rAndB = "R&B"
  case reggae
  case rock
  case samba
  case soulFunk = "Soul/Funk"
  case upNext = "Up Next"

  // Worldwide (not listed above)
  case african = "African Music"
  case afrikaans
  case amapiano
  case arabic
  case baileFunk = "Baile Funk"
  case bollywood
  case brazilianHipHop = "Brazilian Hip Hop"
  case brazilianPop = "Brazilian Pop"
  case brazilianRock = "Brazilian Rock"
  case cPop = "C-Pop"
  case canadian
  case cantopop
  case catalana = "Musica Catalana"
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
  case japanese = "Japanese Music"
  case kPop = "K-Pop"
  case kannada
  case kayokyoku
  case latin
  case malayalam
  case malaysianMusic = "Malaysian Music"
  case mandopop
  case mizrahi
  case mpb = "MPB"
  case musiqueFrancophone = "Musique francophone"
  case musicaMexicana = "Música Mexicana"
  case musicaTropical = "Música Tropical"
  case pilipino = "Original Pilipino Music"
  case popItaliano = "Pop Italiano"
  case popLatino = "Pop Latino"
  case punjabi
  case rapItaliano = "Rap Italiano"
  case religiKetuhanan = "Religi/Ketuhanan"
  case rockInSpanish = "Rock in Spanish"
  case rockYAlternativo = "Rock y Alternativo"
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
  case tpop = "T=Pop"
  case urbanoLatino = "Urbano Latino"
  case valienato
  case vietnamese = "Vietnamese Music"
  case worldwide

  // Moods and Activities
  
  case afterHours = "After Hours"
  case aloneTime = "Alone Time"
  case chill
  case commuting
  case eatingAndCooking = "Eating & Cooking"
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
  case sing
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
  public var id: Self {
    self
  }
}

extension AppleMusicCategory: CustomStringConvertible {
  public var description: String {
    rawValue.first!.isLetter ? rawValue.capitalized : rawValue
  }
}

extension AppleMusicCategory {
  public static let appleMusicCategories = AppleMusicCategory.allCases
  public static let defaultMusicCategory = AppleMusicCategory.spatialAudio
  public static let appleMusicSpatial = AppleMusicCategory.spatialAudio
  public static let appleMusicEssentials = AppleMusicCategory.essentials
  public static let appleMusicDecades: [AppleMusicCategory]
  = [.decades, .oldies, .twenties, .thirties, .forties, .fifties, .sixties, .seventies, .eighties, .nineties, .twoThousands, .twentyTens]//, .twentyTwenties]
  public static let appleMusicGenres: [AppleMusicCategory]
  = [.spatialAudio, .essentials, .charts, .comingSoon, .acoustic, .afrobeats, .alternative, .americana, .anime, .appleMusicRadio, .behindTheSongs, .blues, .christian,
     .classicRock, .classical, .country, .dance, .devotional, .djMixes, .electronic, .family,
     .filmTVStage, .gospel, .hardRock, .hits, .hipHop, .holiday, .indie, .jazz,
     .kids, .live, .metal, .pop, .pride, .punk,
     .radio, .rAndB, .reggae, .rock,  .samba, .soulFunk, .upNext, .worldwide]

  public static let appleMusicWorldwide: [AppleMusicCategory]
  = [.african, .afrikaans, .afrobeats, .amapiano, .arabic, .baileFunk, .bollywood, .brazilianPop, .brazilianRock, .brazilianHipHop, .cPop,
     .canadian, .cantopop,  .catalana, .deutschpop, .deutschrap, .firstNationsAustralia,
     .flamenco, .frenchPop, .frenchRap, .halk, .horspiele, .indianIndependent, .indonesianMusic,
     .islamic, .jHipHop, .jPop, .jRock, .japanese, .kPop, .kannada, .kayokyoku, .latin, .malayalam, .malaysianMusic,
     .mandopop, .mizrahi, .mpb, .musicaMexicana, .musicaTropical, .musiqueFrancophone, .pilipino,
     .popItaliano, .popLatino, .punjabi, .rapItaliano, .religiKetuhanan, .rockInSpanish, .rockYAlternativo,
     .russian, .russianHipHop, .russianPop, .russianRock, .sanat, .schlager, .sertanejo,
     .tamil, .telugu, .thaiMusic, .tpop, .valienato, .urbanoLatino, .vietnamese, .worldwide]

  public static let appleMusicMoodsAndActivities: [AppleMusicCategory]
  = [ .afterHours, .aloneTime, .chill, .commuting, .eatingAndCooking, .evening,
      .feelGood, .feelingBlue, .fitness, .focus, .gaming, .heartbreak, .home,
      .morning, .motivation, .outdoors, .party, .romance, .sing, .sleep, .social, .sports, .summertimeSounds,
      .vacation, .weekend, .wellbeing, .work ]
  
  public static let appleMusicClassical: [AppleMusicCategory]
  = []
}
