import Foundation

struct Festival: Identifiable, Hashable {
    let id: String
    let name: String
    let subtitle: String
    let deity: Deity
    let countdownText: String
    let timingNotice: String
    let overview: String
    let significance: String
    let preparationTimeline: [PreparationTask]
    let pujaItems: [PujaItem]
    let pujaSteps: [PujaStep]
    let prasadam: [PrasadamSuggestion]
    let kidsLesson: String
    let sources: [SourceReference]
}

struct Deity: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let symbolism: [SymbolismPoint]
}

struct SymbolismPoint: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let explanation: String
}

struct PreparationTask: Identifiable, Hashable {
    let id = UUID()
    let timeframe: String
    let title: String
    let details: String
}

struct PujaItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let substitution: String?
}

struct PujaStep: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let instruction: String
    let why: String
    let prayerTitle: String?
    let transliteration: String?
    let meaning: String?
    let reviewStatus: ContentReviewStatus
}

struct PrasadamSuggestion: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let note: String
}

struct PanchangSummary: Hashable {
    let hinduDate: String
    let tithi: String
    let nakshatra: String
    let paksha: String
    let month: String
    let sunrise: String
    let sunset: String
    let rahuKalam: String
    let notice: String
}

struct SourceReference: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let sourceType: String
    let reviewStatus: ContentReviewStatus
    let notes: String
}

enum ContentReviewStatus: String, Hashable {
    case draft = "Draft"
    case researching = "Researching"
    case traditionReviewed = "Tradition reviewed"
    case languageReviewed = "Language reviewed"
    case published = "Published"
}
