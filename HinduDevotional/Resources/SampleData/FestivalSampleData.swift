import Foundation

enum FestivalSampleData {
    static let ganesha = Deity(
        id: "ganesha",
        name: "Lord Ganesha",
        description: "Lord Ganesha is traditionally worshipped as the remover of obstacles, the giver of wisdom, and the deity invoked at the beginning of auspicious work. Interpretations vary across families, regions, and sampradayas.",
        symbolism: [
            SymbolismPoint(title: "Elephant head", explanation: "Commonly explained as wisdom, strength, and the ability to see beyond immediate appearances."),
            SymbolismPoint(title: "Large ears", explanation: "Often understood as a reminder to listen carefully and receive learning with humility."),
            SymbolismPoint(title: "Trunk", explanation: "Traditionally seen as adaptability: gentle enough to pick up a flower and strong enough to move obstacles."),
            SymbolismPoint(title: "Mouse vahana", explanation: "Many traditions explain the mouse as desire or restlessness guided by wisdom."),
            SymbolismPoint(title: "Modak", explanation: "The sweet is associated with the joy and inner reward of spiritual effort."),
            SymbolismPoint(title: "Broken tusk", explanation: "Often interpreted as sacrifice, discipline, and dedication to knowledge.")
        ]
    )

    static let todayPanchang = PanchangSummary(
        hinduDate: "Location-aware Hindu date pending provider",
        tithi: "Provider required",
        nakshatra: "Provider required",
        paksha: "Provider required",
        month: "Provider required",
        sunrise: "Use local sunrise provider",
        sunset: "Use local sunset provider",
        rahuKalam: "Provider required",
        notice: "Festival timing may vary by location, timezone, sunrise, and Panchang tradition."
    )

    static let ganeshChaturthi = Festival(
        id: "ganesh-chaturthi",
        name: "Ganesh Chaturthi",
        subtitle: "A festival honoring Lord Ganesha, traditionally observed with worship, offerings, stories, music, prasadam, and visarjan where followed.",
        deity: ganesha,
        countdownText: "Upcoming date requires location-aware Panchang data",
        timingNotice: "Ganesh Chaturthi dates and puja windows vary by location and Panchang tradition.",
        overview: "Ganesh Chaturthi celebrates Lord Ganesha, who is widely worshipped before new beginnings and important undertakings. The festival invites families to reflect on wisdom, humility, gratitude, and the removal of inner and outer obstacles.",
        significance: "Traditional practice often includes bringing or worshipping a Ganesha murti or image, preparing offerings such as modak or regional prasadam, reciting prayers, singing aarti, sharing food, and respectfully concluding the observance. This app labels regional variations rather than treating one procedure as universal.",
        preparationTimeline: [
            PreparationTask(timeframe: "7 days before", title: "Understand and plan", details: "Read the festival overview, choose a simple home puja flow, and review the checklist."),
            PreparationTask(timeframe: "3 days before", title: "Gather items", details: "Purchase or prepare flowers, fruits, oil or ghee, wicks, incense, and prasadam ingredients."),
            PreparationTask(timeframe: "Previous day", title: "Prepare the space", details: "Clean the puja area, set aside vessels, prepare decorations, and confirm safe lamp placement."),
            PreparationTask(timeframe: "Festival morning", title: "Begin calmly", details: "Bathe, prepare naivedyam where possible, arrange the deity, and begin during the appropriate locally determined time.")
        ],
        pujaItems: [
            PujaItem(name: "Ganesha murti or photo", substitution: "A clean printed image may be used when a murti is not available."),
            PujaItem(name: "Clean cloth and puja platform", substitution: nil),
            PujaItem(name: "Turmeric, kumkum, sandalwood, and akshata", substitution: "Use available traditional items respectfully if one is unavailable."),
            PujaItem(name: "Flowers and durva grass", substitution: "Fresh flowers may substitute when durva is difficult to obtain."),
            PujaItem(name: "Fruits, coconut, betel leaves, and betel nuts", substitution: "Offer seasonal fruit when specific items are unavailable."),
            PujaItem(name: "Deepam, cotton wicks, oil or ghee", substitution: "Use an electric lamp only where open flame is unsafe."),
            PujaItem(name: "Incense and camphor", substitution: "Skip smoke-producing items if health, lease, or fire safety requires it."),
            PujaItem(name: "Modak, kudumulu, undrallu, or laddu", substitution: "Offer homemade or store-bought vegetarian sweets according to family practice.")
        ],
        pujaSteps: [
            PujaStep(title: "Clean and prepare the puja area", instruction: "Place the deity image or murti on a clean platform. Arrange offerings safely and keep water nearby.", why: "Cleanliness marks the space as intentional and helps the family enter the puja with attention and respect.", prayerTitle: nil, transliteration: nil, meaning: nil, reviewStatus: .traditionReviewed),
            PujaStep(title: "Light the deepam", instruction: "Light the oil or ghee lamp and place it safely before the deity.", why: "Light is traditionally understood as knowledge, clarity, and the removal of inner darkness.", prayerTitle: nil, transliteration: nil, meaning: nil, reviewStatus: .traditionReviewed),
            PujaStep(title: "Offer flowers", instruction: "Offer flowers with devotion. If durva grass is available and part of your tradition, offer it respectfully.", why: "Flowers commonly symbolize purity, gratitude, beauty, and surrender.", prayerTitle: nil, transliteration: nil, meaning: nil, reviewStatus: .traditionReviewed),
            PujaStep(title: "Offer naivedyam", instruction: "Place modak, fruit, or other prepared prasadam before Lord Ganesha.", why: "Naivedyam expresses gratitude and recognizes food as a sacred gift before it is shared.", prayerTitle: nil, transliteration: nil, meaning: nil, reviewStatus: .traditionReviewed),
            PujaStep(title: "Aarti and namaskaram", instruction: "Perform aarti according to family practice, then offer namaskaram and pray for wisdom and removal of obstacles.", why: "Aarti is a joyful concluding worship action, and namaskaram expresses humility and reverence.", prayerTitle: "Aarti content requires verified source", transliteration: nil, meaning: nil, reviewStatus: .researching),
            PujaStep(title: "Prasadam distribution", instruction: "Share prasadam with family and guests after the puja.", why: "Sharing prasadam extends the blessing of the puja into family and community life.", prayerTitle: nil, transliteration: nil, meaning: nil, reviewStatus: .traditionReviewed)
        ],
        prasadam: [
            PrasadamSuggestion(name: "Modak", note: "Often associated with Ganesha and prepared in many regional styles."),
            PrasadamSuggestion(name: "Kudumulu or Undrallu", note: "Common in Telugu traditions for Ganesh Chaturthi."),
            PrasadamSuggestion(name: "Laddu", note: "A common sweet offering in many homes.")
        ],
        kidsLesson: "Ganesh Chaturthi can teach children to begin good work with humility, listen well, learn patiently, respect nature, and share food with gratitude.",
        sources: [
            SourceReference(title: "Religious reviewer required", sourceType: "Content review", reviewStatus: .researching, notes: "Mantras, aarti text, Sankalpam, and exact timing must be added only from verified sources."),
            SourceReference(title: "Panchang provider required", sourceType: "Panchang provider", reviewStatus: .draft, notes: "Dates and muhurta are intentionally not hard-coded in sample data.")
        ]
    )
}
