import SwiftUI

enum FestivalDetailSection: String, CaseIterable, Identifiable {
    case overview = "Overview"
    case preparation = "Prepare"
    case puja = "Puja"
    case prasadam = "Prasadam"
    case kids = "Kids"
    case sources = "Sources"

    var id: String { rawValue }
}

struct FestivalDetailView: View {
    let festival: Festival
    let initialSection: FestivalDetailSection

    @State private var selectedSection: FestivalDetailSection
    @State private var checkedItems: Set<UUID> = []

    init(festival: Festival, initialSection: FestivalDetailSection = .overview) {
        self.festival = festival
        self.initialSection = initialSection
        _selectedSection = State(initialValue: initialSection)
    }

    var body: some View {
        ZStack {
            DevotionalTheme.ivory.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DevotionalTheme.contentSpacing) {
                    hero
                    sectionPicker
                    selectedContent
                }
                .padding(20)
            }
        }
        .navigationTitle(festival.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(festival.name)
                .font(.largeTitle.bold())
                .foregroundStyle(DevotionalTheme.ink)
                .dynamicTypeSize(...DynamicTypeSize.accessibility3)

            Text(festival.subtitle)
                .font(.body)
                .foregroundStyle(.secondary)

            Label(festival.timingNotice, systemImage: "location.magnifyingglass")
                .font(.footnote)
                .foregroundStyle(DevotionalTheme.maroon)
                .padding(12)
                .background(DevotionalTheme.gold.opacity(0.14), in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
        }
    }

    private var sectionPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(FestivalDetailSection.allCases) { section in
                    Button {
                        selectedSection = section
                    } label: {
                        Text(section.rawValue)
                            .font(.subheadline.weight(.semibold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundStyle(selectedSection == section ? .white : DevotionalTheme.maroon)
                            .background(
                                selectedSection == section ? DevotionalTheme.saffron : DevotionalTheme.gold.opacity(0.16),
                                in: Capsule()
                            )
                    }
                    .accessibilityAddTraits(selectedSection == section ? .isSelected : [])
                }
            }
            .padding(.vertical, 2)
        }
    }

    @ViewBuilder
    private var selectedContent: some View {
        switch selectedSection {
        case .overview:
            overviewSection
        case .preparation:
            preparationSection
        case .puja:
            pujaSection
        case .prasadam:
            prasadamSection
        case .kids:
            kidsSection
        case .sources:
            sourcesSection
        }
    }

    private var overviewSection: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            DevotionalCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Festival Overview")
                        .font(.title3.bold())
                    Text(festival.overview)
                    Text(festival.significance)
                        .foregroundStyle(.secondary)
                }
            }

            DevotionalCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Deity")
                        .font(.title3.bold())
                    Text(festival.deity.name)
                        .font(.headline)
                    Text(festival.deity.description)
                        .foregroundStyle(.secondary)

                    ForEach(festival.deity.symbolism) { point in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(point.title)
                                .font(.subheadline.weight(.semibold))
                            Text(point.explanation)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 4)
                    }
                }
            }
        }
    }

    private var preparationSection: some View {
        VStack(spacing: DevotionalTheme.contentSpacing) {
            DevotionalCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Preparation Timeline")
                        .font(.title3.bold())
                    ForEach(festival.preparationTimeline) { task in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(task.timeframe)
                                .font(.caption.weight(.bold))
                                .foregroundStyle(DevotionalTheme.saffron)
                            Text(task.title)
                                .font(.headline)
                            Text(task.details)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            DevotionalCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Puja Checklist")
                        .font(.title3.bold())
                    ForEach(festival.pujaItems) { item in
                        ChecklistRow(
                            item: item,
                            isChecked: checkedItems.contains(item.id),
                            toggle: { toggleItem(item.id) }
                        )
                    }
                }
            }
        }
    }

    private var pujaSection: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("Guided Home Puja")
                    .font(.title3.bold())

                Text("This is a general home guide. Procedures vary by family, region, temple, priest, and sampradaya.")
                    .font(.footnote)
                    .foregroundStyle(DevotionalTheme.maroon)

                ForEach(Array(festival.pujaSteps.enumerated()), id: \.element.id) { index, step in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Step \(index + 1) of \(festival.pujaSteps.count)")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(DevotionalTheme.saffron)
                        Text(step.title)
                            .font(.headline)
                        Text(step.instruction)
                            .font(.body)
                        DisclosureGroup("Why do we do this?") {
                            Text(step.why)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding(.top, 4)
                        }
                        if let prayerTitle = step.prayerTitle {
                            Label(prayerTitle, systemImage: "checkmark.seal")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                    Divider()
                }
            }
        }
    }

    private var prasadamSection: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Prasadam Suggestions")
                    .font(.title3.bold())
                ForEach(festival.prasadam) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.note)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }

    private var kidsSection: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("Kids Explanation")
                    .font(.title3.bold())
                Text(festival.kidsLesson)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var sourcesSection: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Sources and Review")
                    .font(.title3.bold())
                ForEach(festival.sources) { source in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(source.title)
                            .font(.headline)
                        Text(source.sourceType)
                            .font(.subheadline)
                            .foregroundStyle(DevotionalTheme.saffron)
                        Text(source.notes)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(source.reviewStatus.rawValue)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(DevotionalTheme.maroon)
                    }
                }
            }
        }
    }

    private func toggleItem(_ id: UUID) {
        if checkedItems.contains(id) {
            checkedItems.remove(id)
        } else {
            checkedItems.insert(id)
        }
    }
}

private struct ChecklistRow: View {
    let item: PujaItem
    let isChecked: Bool
    let toggle: () -> Void

    var body: some View {
        Button(action: toggle) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(isChecked ? DevotionalTheme.saffron : .secondary)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 3) {
                    Text(item.name)
                        .font(.body)
                        .foregroundStyle(DevotionalTheme.ink)
                    if let substitution = item.substitution {
                        Text(substitution)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(item.name)
        .accessibilityValue(isChecked ? "Checked" : "Not checked")
    }
}

#Preview {
    NavigationStack {
        FestivalDetailView(festival: FestivalSampleData.ganeshChaturthi)
    }
}
