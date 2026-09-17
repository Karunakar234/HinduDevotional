import Foundation

struct FestivalGuide: Identifiable, Hashable {
    let id: String
    let nameEnglish: String
    let nameTelugu: String
    let nameSanskrit: String
    let alternativeNames: [String]
    let category: FestivalGuideCategory
    let deity: [String]
    let associatedDeities: [String]
    let panchang: FestivalPanchangRule
    let festivalDateRule: VerifiedText
    let pujaTimeRule: VerifiedText
    let significance: VerifiedText
    let history: VerifiedText
    let legend: VerifiedText
    let scripturalBackground: VerifiedText
    let regionalTraditions: [RegionalVariation]
    let pujaItems: [FestivalPujaItem]
    let preparationSteps: [LocalizedInstruction]
    let pujaSetup: [LocalizedInstruction]
    let pujaModes: [PujaModeGuide]
    let mantras: [DevotionalText]
    let slokas: [DevotionalText]
    let ashtottaram: DevotionalText?
    let sahasranamam: DevotionalText?
    let vratamKatha: DevotionalText?
    let naivedyam: [FoodOffering]
    let prasadam: [FoodOffering]
    let fastingRules: VerifiedText
    let paranaRules: VerifiedText
    let dos: [LocalizedInstruction]
    let donts: [LocalizedInstruction]
    let afterPujaSteps: [LocalizedInstruction]
    let visarjanSteps: [LocalizedInstruction]
    let templeTraditions: [VerifiedText]
    let sources: [FestivalSource]
}

enum FestivalGuideCategory: String, Hashable {
    case newYearSpring = "Telugu / South Indian New Year & Spring"
    case vishnu = "Vishnu / Vaishnava"
    case krishna = "Krishna"
    case ganesha = "Ganesha"
    case shiva = "Shiva"
    case shakti = "Goddess / Shakti"
    case deepavali = "Deepavali Cycle"
    case navaratri = "Navaratri"
    case vrata = "Vratam"
}

enum VerificationStatus: String, Hashable {
    case reviewed = "Reviewed"
    case sourceBacked = "Source-backed"
    case traditionSummary = "Tradition summary"
    case requiresVerification = "Requires verification"
}

struct VerifiedText: Hashable {
    let english: String
    let telugu: String
    let status: VerificationStatus
    let sourceIds: [String]
    let notes: String?
}

struct FestivalPanchangRule: Hashable {
    let tithi: String
    let paksha: String
    let masa: String
    let nakshatraRequirement: String
    let sunriseRule: String
    let sunsetRule: String
}

struct RegionalVariation: Identifiable, Hashable {
    let id = UUID()
    let tradition: String
    let region: String
    let descriptionEnglish: String
    let descriptionTelugu: String
    let status: VerificationStatus
}

struct FestivalPujaItem: Identifiable, Hashable {
    let id = UUID()
    let nameEnglish: String
    let nameTelugu: String
    let required: Bool
    let substitutions: [String]
    let notes: String?
}

struct LocalizedInstruction: Identifiable, Hashable {
    let id = UUID()
    let english: String
    let telugu: String
    let status: VerificationStatus
}

enum PujaMode: String, Hashable {
    case quick = "Quick Puja"
    case standard = "Standard Puja"
    case detailed = "Detailed Traditional Puja"
}

struct PujaModeGuide: Identifiable, Hashable {
    let id = UUID()
    let mode: PujaMode
    let steps: [FestivalPujaStep]
}

struct FestivalPujaStep: Identifiable, Hashable {
    let id = UUID()
    let stepNumber: Int
    let stepNameEnglish: String
    let stepNameTelugu: String
    let requiredItems: [String]
    let instructionEnglish: String
    let instructionTelugu: String
    let mantra: DevotionalText?
    let repeatCount: String?
    let offering: String?
    let duration: String?
    let optional: Bool
    let tradition: String
    let verificationStatus: VerificationStatus
}

struct DevotionalText: Identifiable, Hashable {
    let id: String
    let titleEnglish: String
    let titleTelugu: String
    let sanskrit: String?
    let teluguScript: String?
    let transliteration: String?
    let meaningEnglish: String?
    let meaningTelugu: String?
    let sourceIds: [String]
    let status: VerificationStatus
    let notes: String?
}

struct FoodOffering: Identifiable, Hashable {
    let id = UUID()
    let nameEnglish: String
    let nameTelugu: String
    let significanceEnglish: String
    let significanceTelugu: String
    let dietaryNotes: [String]
    let status: VerificationStatus
}

struct FestivalSource: Identifiable, Hashable {
    let id: String
    let title: String
    let sourceType: String
    let url: String?
    let notes: String
}
