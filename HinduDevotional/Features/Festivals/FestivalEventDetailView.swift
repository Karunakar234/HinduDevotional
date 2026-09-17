import SwiftUI

struct FestivalEventDetailView: View {
    let event: FestivalEvent
    let secondaryLanguage: DevotionalLanguage

    private var panchang: PanchangSummary {
        FestivalSampleData.panchang(for: event.date)
    }

    private var isGaneshFestival: Bool {
        event.title.localizedCaseInsensitiveContains("Ganesh") || event.title.localizedCaseInsensitiveContains("Ganesha")
    }

    var body: some View {
        ZStack {
            DevotionalTheme.ivory.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DevotionalTheme.contentSpacing) {
                    hero
                    detailCard
                    timingCard
                    nextStepsCard
                    reviewCard
                }
                .padding(20)
            }
        }
        .navigationTitle(event.title)
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(event.title)
                .font(.largeTitle.bold())
                .foregroundStyle(DevotionalTheme.ink)
                .dynamicTypeSize(...DynamicTypeSize.accessibility3)

            Text(event.date, format: .dateTime.weekday(.wide).month(.wide).day().year())
                .font(.title3.weight(.semibold))
                .foregroundStyle(DevotionalTheme.maroon)

            if secondaryLanguage == .telugu {
                Text("పండుగ వివరాలు")
                    .font(.headline)
                    .foregroundStyle(DevotionalTheme.saffron)
            }
        }
    }

    private var detailCard: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 12) {
                FestivalDetailMetric(title: "Category", localizedTitle: teluguTitle("వర్గం"), value: event.category.rawValue)
                FestivalDetailMetric(title: "Location Basis", localizedTitle: teluguTitle("స్థానం"), value: "Default location: Tampa, Florida")
                if let notes = event.notes {
                    FestivalDetailMetric(title: "Notes", localizedTitle: teluguTitle("గమనికలు"), value: notes)
                }
            }
        }
    }

    private var timingCard: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Day Timing")
                    .font(.title3.bold())
                    .foregroundStyle(DevotionalTheme.ink)
                if secondaryLanguage == .telugu {
                    Text("రోజు సమయాలు")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(DevotionalTheme.maroon)
                }

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 10) {
                    FestivalDetailMetric(title: "Sunrise", localizedTitle: teluguTitle("సూర్యోదయం"), value: panchang.sunrise)
                    FestivalDetailMetric(title: "Sunset", localizedTitle: teluguTitle("సూర్యాస్తమయం"), value: panchang.sunset)
                    FestivalDetailMetric(title: "Tithi", localizedTitle: teluguTitle("తిథి"), value: panchang.tithi)
                    FestivalDetailMetric(title: "Nakshatra", localizedTitle: teluguTitle("నక్షత్రం"), value: panchang.nakshatra)
                }
            }
        }
    }

    private var nextStepsCard: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("Next Steps")
                    .font(.title3.bold())
                    .foregroundStyle(DevotionalTheme.ink)
                if secondaryLanguage == .telugu {
                    Text("తదుపరి చర్యలు")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(DevotionalTheme.maroon)
                }

                if isGaneshFestival {
                    NavigationLink {
                        FestivalDetailView(
                            festival: FestivalSampleData.ganeshChaturthi,
                            secondaryLanguage: secondaryLanguage,
                            initialSection: .overview
                        )
                    } label: {
                        Label("Open Ganesh Chaturthi Guide", systemImage: "book")
                    }
                    .buttonStyle(PrimaryDevotionalButtonStyle())
                } else {
                    Text("A full festival guide can be added here with deity, significance, preparation checklist, puja steps, prasadam, music, stories, and sources.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                    if secondaryLanguage == .telugu {
                        Text("ఈ పండుగకు పూర్తి మార్గదర్శిని తరువాత జోడించవచ్చు.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }

    private var reviewCard: some View {
        DevotionalCard {
            Label("Festival dates can vary by location and Panchang tradition. Detailed tithi, nakshatra, muhurta, and puja windows require a verified Panchang provider.", systemImage: "checkmark.seal")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private func teluguTitle(_ title: String) -> String? {
        secondaryLanguage == .telugu ? title : nil
    }
}

private struct FestivalDetailMetric: View {
    let title: String
    let localizedTitle: String?
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            if let localizedTitle {
                Text(localizedTitle)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.maroon)
            }
            Text(value)
                .font(.subheadline)
                .foregroundStyle(DevotionalTheme.ink)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color.white.opacity(0.46), in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        FestivalEventDetailView(
            event: FestivalSampleData.festivalEvents2026[0],
            secondaryLanguage: .telugu
        )
    }
}
