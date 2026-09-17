import SwiftUI

struct FestivalYearView: View {
    @Binding var secondaryLanguage: DevotionalLanguage

    private let calendar = Calendar(identifier: .gregorian)

    private var groupedEvents: [(month: Date, events: [FestivalEvent])] {
        let grouped = Dictionary(grouping: FestivalSampleData.festivalEvents2026) { event in
            let components = calendar.dateComponents([.year, .month], from: event.date)
            return calendar.date(from: components) ?? event.date
        }

        return grouped
            .map { (month: $0.key, events: $0.value.sorted { $0.date < $1.date }) }
            .sorted { $0.month < $1.month }
    }

    var body: some View {
        ZStack {
            DevotionalTheme.ivory.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DevotionalTheme.contentSpacing) {
                    header
                    yearSummary

                    ForEach(groupedEvents, id: \.month) { group in
                        monthSection(month: group.month, events: group.events)
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Festivals")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("2026 Hindu Festivals")
                .font(.largeTitle.bold())
                .foregroundStyle(DevotionalTheme.ink)
            if secondaryLanguage == .telugu {
                Text("2026 హిందూ పండుగలు")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.maroon)
            }
            Text("Browse the full year, then open a festival for date, category, notes, Panchang caveats, and next steps.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var yearSummary: some View {
        DevotionalCard {
            HStack(spacing: 14) {
                FestivalCountBadge(count: FestivalSampleData.festivalEvents2026.count, title: "Events", localizedTitle: teluguTitle("ఈవెంట్లు"))
                FestivalCountBadge(count: majorFestivalCount, title: "Major", localizedTitle: teluguTitle("ప్రధాన"))
                FestivalCountBadge(count: vrataCount, title: "Vratam", localizedTitle: teluguTitle("వ్రతం"))
            }
        }
    }

    private func monthSection(month: Date, events: [FestivalEvent]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(month, format: .dateTime.month(.wide).year())
                .font(.title3.bold())
                .foregroundStyle(DevotionalTheme.ink)

            VStack(spacing: 10) {
                ForEach(events) { event in
                    NavigationLink {
                        FestivalEventDetailView(event: event, secondaryLanguage: secondaryLanguage)
                    } label: {
                        FestivalYearRow(event: event)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var majorFestivalCount: Int {
        FestivalSampleData.festivalEvents2026.filter { $0.category == .majorFestival }.count
    }

    private var vrataCount: Int {
        FestivalSampleData.festivalEvents2026.filter { $0.category == .vrata }.count
    }

    private func teluguTitle(_ title: String) -> String? {
        secondaryLanguage == .telugu ? title : nil
    }
}

private struct FestivalCountBadge: View {
    let count: Int
    let title: String
    let localizedTitle: String?

    var body: some View {
        VStack(spacing: 3) {
            Text("\(count)")
                .font(.title2.bold())
                .foregroundStyle(DevotionalTheme.saffron)
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(DevotionalTheme.ink)
            if let localizedTitle {
                Text(localizedTitle)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.maroon)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct FestivalYearRow: View {
    let event: FestivalEvent

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(spacing: 2) {
                Text(event.date, format: .dateTime.month(.abbreviated))
                    .font(.caption.weight(.bold))
                Text(event.date, format: .dateTime.day())
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(width: 54, height: 54)
            .background(DevotionalTheme.saffron, in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                    .foregroundStyle(DevotionalTheme.ink)
                Text(event.date, format: .dateTime.weekday(.wide))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack(spacing: 6) {
                    Text(event.category.rawValue)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(DevotionalTheme.saffron)
                    if let notes = event.notes {
                        Text(notes)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)
                .padding(.top, 6)
        }
        .padding(12)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous)
                .stroke(DevotionalTheme.gold.opacity(0.18), lineWidth: 1)
        }
    }
}

private struct FestivalYearPreview: View {
    @State private var secondaryLanguage: DevotionalLanguage = .telugu

    var body: some View {
        NavigationStack {
            FestivalYearView(secondaryLanguage: $secondaryLanguage)
        }
    }
}

#Preview {
    FestivalYearPreview()
}
