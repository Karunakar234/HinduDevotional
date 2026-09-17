import SwiftUI

struct ExploreView: View {
    @Binding var secondaryLanguage: DevotionalLanguage

    var body: some View {
        ZStack {
            DevotionalTheme.ivory.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DevotionalTheme.contentSpacing) {
                    header
                    exploreLinks
                }
                .padding(20)
            }
        }
        .navigationTitle("Explore")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Explore")
                .font(.largeTitle.bold())
                .foregroundStyle(DevotionalTheme.ink)
            if secondaryLanguage == .telugu {
                Text("అన్వేషించండి")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.maroon)
            }
            Text("Festivals, deities, stories, prasadam, fasting guides, kids content, and family traditions will live here.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var exploreLinks: some View {
        VStack(spacing: 12) {
            NavigationLink {
                FestivalYearView(secondaryLanguage: $secondaryLanguage)
            } label: {
                ExploreLinkRow(
                    title: "Year Festivals",
                    localizedTitle: secondaryLanguage == .telugu ? "సంవత్సర పండుగలు" : nil,
                    subtitle: "Browse all 2026 festival dates and open festival details.",
                    systemImage: "sparkles"
                )
            }
            .buttonStyle(.plain)

            ExploreLinkRow(
                title: "Deities",
                localizedTitle: secondaryLanguage == .telugu ? "దేవతలు" : nil,
                subtitle: "Ganesha, Shiva, Vishnu, Lakshmi, Saraswati, Hanuman, Devi, and more.",
                systemImage: "books.vertical"
            )
            .opacity(0.72)

            ExploreLinkRow(
                title: "Prasadam",
                localizedTitle: secondaryLanguage == .telugu ? "ప్రసాదం" : nil,
                subtitle: "Festival recipes, ingredients, dietary notes, and significance.",
                systemImage: "fork.knife"
            )
            .opacity(0.72)
        }
    }
}

private struct ExploreLinkRow: View {
    let title: String
    let localizedTitle: String?
    let subtitle: String
    let systemImage: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 42, height: 42)
                .background(DevotionalTheme.saffron, in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(DevotionalTheme.ink)
                if let localizedTitle {
                    Text(localizedTitle)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(DevotionalTheme.maroon)
                }
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)
                .padding(.top, 8)
        }
        .padding(14)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous)
                .stroke(DevotionalTheme.gold.opacity(0.18), lineWidth: 1)
        }
    }
}

private struct ExplorePreview: View {
    @State private var secondaryLanguage: DevotionalLanguage = .telugu

    var body: some View {
        NavigationStack {
            ExploreView(secondaryLanguage: $secondaryLanguage)
        }
    }
}

#Preview {
    ExplorePreview()
}
