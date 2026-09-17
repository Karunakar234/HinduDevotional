import SwiftUI

enum ExploreSection: String, CaseIterable, Identifiable, Hashable {
    case deities = "Deities"
    case stories = "Stories"
    case kids = "Kids"
    case prasadam = "Prasadam"
    case fasting = "Fasting"
    case mantras = "Mantras & Prayers"
    case family = "Family Traditions"
    case review = "Sources & Review"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .deities: "books.vertical"
        case .stories: "book.pages"
        case .kids: "figure.2.and.child.holdinghands"
        case .prasadam: "fork.knife"
        case .fasting: "leaf"
        case .mantras: "text.book.closed"
        case .family: "house.and.flag"
        case .review: "checkmark.seal"
        }
    }

    var teluguTitle: String {
        switch self {
        case .deities: "దేవతలు"
        case .stories: "కథలు"
        case .kids: "పిల్లల కోసం"
        case .prasadam: "ప్రసాదం"
        case .fasting: "ఉపవాసం"
        case .mantras: "మంత్రాలు మరియు ప్రార్థనలు"
        case .family: "కుటుంబ సంప్రదాయాలు"
        case .review: "మూలాలు మరియు సమీక్ష"
        }
    }
}

struct ExploreDetailView: View {
    let section: ExploreSection
    let secondaryLanguage: DevotionalLanguage

    var body: some View {
        ZStack {
            DevotionalTheme.ivory.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DevotionalTheme.contentSpacing) {
                    header
                    content
                    reviewNotice
                }
                .padding(20)
            }
        }
        .navigationTitle(section.rawValue)
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: section.systemImage)
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(DevotionalTheme.saffron, in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
                .accessibilityHidden(true)

            Text(section.rawValue)
                .font(.largeTitle.bold())
                .foregroundStyle(DevotionalTheme.ink)

            if secondaryLanguage == .telugu {
                Text(section.teluguTitle)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.maroon)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch section {
        case .deities:
            deitiesContent
        case .stories:
            storiesContent
        case .kids:
            kidsContent
        case .prasadam:
            prasadamContent
        case .fasting:
            fastingContent
        case .mantras:
            mantrasContent
        case .family:
            familyContent
        case .review:
            reviewContent
        }
    }

    private var deitiesContent: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            DevotionalCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Featured Deity")
                        .font(.title3.bold())
                    Text(FestivalSampleData.ganesha.name)
                        .font(.headline)
                    Text(FestivalSampleData.ganesha.description)
                        .foregroundStyle(.secondary)
                    if secondaryLanguage == .telugu {
                        Text("శ్రీ గణేశుడు అడ్డంకులను తొలగించే దేవుడిగా, జ్ఞానం ప్రసాదించే దేవుడిగా అనేక సంప్రదాయాలలో ఆరాధించబడతాడు.")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            symbolList

            NavigationLink {
                FestivalDetailView(festival: FestivalSampleData.ganeshChaturthi, secondaryLanguage: secondaryLanguage)
            } label: {
                Label("Open Ganesh Chaturthi Guide", systemImage: "book")
            }
            .buttonStyle(PrimaryDevotionalButtonStyle())
        }
    }

    private var symbolList: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Symbolism")
                    .font(.title3.bold())
                ForEach(FestivalSampleData.ganesha.symbolism) { point in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(point.title)
                            .font(.headline)
                        Text(point.explanation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }

    private var storiesContent: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            InfoCard(title: "Why We Celebrate", localizedTitle: telugu("ఎందుకు జరుపుకుంటాము"), body: FestivalSampleData.ganeshChaturthi.overview)
            InfoCard(title: "Story Modes", localizedTitle: telugu("కథ రకాలూ"), body: "Each festival story should support a 2-minute explanation, 5-minute explanation, deep dive, and kids story. Scriptural narrative, traditional belief, regional custom, and historical evidence should be clearly labeled.")
            InfoCard(title: "Ganesh Chaturthi Kids Lesson", localizedTitle: telugu("పిల్లల పాఠం"), body: FestivalSampleData.ganeshChaturthi.kidsLesson)
        }
    }

    private var kidsContent: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            InfoCard(title: "Kids Mode", localizedTitle: telugu("పిల్లల మోడ్"), body: "Stories, simple deity introductions, what children can learn, simple prayers, pronunciation practice, quizzes, and respectful helper badges.")
            InfoCard(title: "Learning Values", localizedTitle: telugu("నేర్చుకునే విలువలు"), body: FestivalSampleData.ganeshChaturthi.kidsLesson)
            InfoCard(title: "Respectful Activities", localizedTitle: telugu("గౌరవప్రదమైన కార్యకలాపాలు"), body: "Coloring, memory cards, pronunciation practice, and family discussion prompts should support learning without trivializing worship.")
        }
    }

    private var prasadamContent: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Ganesh Chaturthi Prasadam")
                    .font(.title3.bold())
                if secondaryLanguage == .telugu {
                    Text("వినాయక చవితి ప్రసాదం")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(DevotionalTheme.maroon)
                }
                ForEach(FestivalSampleData.ganeshChaturthi.prasadam) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.note)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                Text("Full recipes should include ingredients, quantities, preparation time, cooking time, steps, festival significance, dietary notes, and allergy information.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var fastingContent: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            InfoCard(title: "Fasting Guide", localizedTitle: telugu("ఉపవాస మార్గదర్శిని"), body: "Explain who traditionally observes the vrat, why, common practices, allowed foods by tradition, start/end timing, and regional variations.")
            InfoCard(title: "Safety", localizedTitle: telugu("ఆరోగ్య జాగ్రత్త"), body: "Do not present fasting as a medical requirement. Children, pregnant people, older adults, and anyone with medical conditions should follow medical advice and family guidance.")
            InfoCard(title: "Review Needed", localizedTitle: telugu("సమీక్ష అవసరం"), body: "Specific fasting rules must be reviewed by knowledgeable tradition reviewers before publication.")
        }
    }

    private var mantrasContent: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            InfoCard(title: "Prayer Library", localizedTitle: telugu("ప్రార్థనల గ్రంథాలయం"), body: "Mantras, slokas, stotrams, aarti, and meanings should show original script, transliteration, English meaning, and source metadata.")
            InfoCard(title: "Copyright Rule", localizedTitle: telugu("హక్కుల నియమం"), body: "Do not copy copyrighted modern translations, song lyrics, or recordings. Use public-domain, licensed, or verified source material only.")
        }
    }

    private var familyContent: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            InfoCard(title: "My Family Traditions", localizedTitle: telugu("మా కుటుంబ సంప్రదాయాలు"), body: "Families can save custom puja steps, family prayers, recipes, festival photos, notes, preferred language, and regional tradition.")
            InfoCard(title: "Tradition Label", localizedTitle: telugu("సంప్రదాయం గుర్తింపు"), body: "Family-specific notes should be labeled as family tradition, not universal Hindu practice.")
        }
    }

    private var reviewContent: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            InfoCard(title: "Content Review", localizedTitle: telugu("విషయ సమీక్ష"), body: "Statuses include Draft, Researching, Tradition reviewed, Language reviewed, and Published.")
            InfoCard(title: "Review Flags", localizedTitle: telugu("సమీక్ష గుర్తులు"), body: "Reviewers can flag incorrect mantra, pronunciation issue, wrong deity association, regional difference, incorrect timing, translation issue, source missing, or copyright concern.")
            InfoCard(title: "Source Types", localizedTitle: telugu("మూలాల రకాలు"), body: "Scriptural text, traditional commentary, temple guidance, Panchang provider, academic research, and community or family tradition should be clearly distinguished.")
        }
    }

    private var reviewNotice: some View {
        DevotionalCard {
            Label("Detailed religious content must be source-backed and reviewed before publication.", systemImage: "checkmark.seal")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private func telugu(_ text: String) -> String? {
        secondaryLanguage == .telugu ? text : nil
    }
}

private struct InfoCard: View {
    let title: String
    let localizedTitle: String?
    let body: String

    var body: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title3.bold())
                if let localizedTitle {
                    Text(localizedTitle)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(DevotionalTheme.maroon)
                }
                Text(body)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExploreDetailView(section: .deities, secondaryLanguage: .telugu)
    }
}
