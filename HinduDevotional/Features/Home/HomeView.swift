import SwiftUI

struct HomeView: View {
    let festival: Festival
    let panchang: PanchangSummary

    var body: some View {
        ZStack {
            DevotionalTheme.ivory.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DevotionalTheme.contentSpacing) {
                    header
                    upcomingFestivalCard
                    quickActions
                    panchangCard
                    dailyDevotionCard
                    reviewNoticeCard
                }
                .padding(20)
            }
        }
        .navigationTitle("Namaste")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "person.crop.circle")
                }
                .accessibilityLabel("Profile and settings")
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Date.now, format: .dateTime.weekday(.wide).month(.wide).day().year())
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Today's Devotion")
                .font(.largeTitle.bold())
                .foregroundStyle(DevotionalTheme.ink)
                .dynamicTypeSize(...DynamicTypeSize.accessibility3)

            Text("A calm daily dashboard for festival timing, Panchang context, preparation, puja, music, and meaning.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var upcomingFestivalCard: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 14) {
                Label("Upcoming Festival", systemImage: "sparkles")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.saffron)

                VStack(alignment: .leading, spacing: 6) {
                    Text(festival.name)
                        .font(.title2.bold())
                        .foregroundStyle(DevotionalTheme.ink)

                    Text(festival.countdownText)
                        .font(.headline)
                        .foregroundStyle(DevotionalTheme.maroon)

                    Text(festival.subtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                NavigationLink {
                    FestivalDetailView(festival: festival)
                } label: {
                    Label("Prepare for Puja", systemImage: "checklist")
                }
                .buttonStyle(PrimaryDevotionalButtonStyle())
            }
        }
    }

    private var quickActions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
                .foregroundStyle(DevotionalTheme.ink)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                NavigationLink {
                    FestivalDetailView(festival: festival)
                } label: {
                    Label("Learn Why", systemImage: "book")
                }
                .buttonStyle(SecondaryDevotionalButtonStyle())

                NavigationLink {
                    FestivalDetailView(festival: festival, initialSection: .puja)
                } label: {
                    Label("Start Puja", systemImage: "hands.sparkles")
                }
                .buttonStyle(SecondaryDevotionalButtonStyle())

                Button {
                } label: {
                    Label("Play Songs", systemImage: "play.circle")
                }
                .buttonStyle(SecondaryDevotionalButtonStyle())

                Button {
                } label: {
                    Label("Reminders", systemImage: "bell")
                }
                .buttonStyle(SecondaryDevotionalButtonStyle())
            }
        }
    }

    private var panchangCard: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 14) {
                Label("Today's Panchang", systemImage: "sun.max")
                    .font(.headline)
                    .foregroundStyle(DevotionalTheme.ink)

                Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 10) {
                    GridRow {
                        PanchangMetric(title: "Tithi", value: panchang.tithi)
                        PanchangMetric(title: "Nakshatra", value: panchang.nakshatra)
                    }
                    GridRow {
                        PanchangMetric(title: "Sunrise", value: panchang.sunrise)
                        PanchangMetric(title: "Rahu Kalam", value: panchang.rahuKalam)
                    }
                }

                Text(panchang.notice)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var dailyDevotionCard: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 10) {
                Label("Daily Mantra", systemImage: "text.book.closed")
                    .font(.headline)
                    .foregroundStyle(DevotionalTheme.ink)

                Text("Prayer text will appear here only after a verified source and language review are attached.")
                    .font(.body)
                    .foregroundStyle(.secondary)

                Button {
                } label: {
                    Label("View Meaning", systemImage: "character.book.closed")
                }
                .buttonStyle(SecondaryDevotionalButtonStyle())
            }
        }
    }

    private var reviewNoticeCard: some View {
        DevotionalCard {
            Label("Religious text, Sankalpam, dates, and muhurta require verified sources before publication.", systemImage: "checkmark.seal")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

private struct PanchangMetric: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.subheadline)
                .foregroundStyle(DevotionalTheme.ink)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        HomeView(
            festival: FestivalSampleData.ganeshChaturthi,
            panchang: FestivalSampleData.todayPanchang
        )
    }
}
