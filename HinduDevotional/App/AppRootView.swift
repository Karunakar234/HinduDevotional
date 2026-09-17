import SwiftUI

enum AppTab: Hashable {
    case home
    case calendar
    case puja
    case devotional
    case explore
}

struct AppRootView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView(
                    festival: FestivalSampleData.ganeshChaturthi,
                    panchang: FestivalSampleData.todayPanchang
                )
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(AppTab.home)

            PlaceholderTabView(
                title: "Festival Calendar",
                systemImage: "calendar",
                message: "Month view, festival markers, deity filters, regional filters, and location-aware dates will build on the Panchang provider abstraction."
            )
            .tabItem { Label("Calendar", systemImage: "calendar") }
            .tag(AppTab.calendar)

            PlaceholderTabView(
                title: "Puja",
                systemImage: "hands.sparkles",
                message: "Guided Puja Mode will present one step at a time with Why explanations, reviewed prayers, audio hooks, and large accessible text."
            )
            .tabItem { Label("Puja", systemImage: "hands.sparkles") }
            .tag(AppTab.puja)

            PlaceholderTabView(
                title: "Devotional",
                systemImage: "music.note.list",
                message: "Mantras, aarti, bhajans, playlists, and MusicKit search will appear here through licensed providers and reviewed content."
            )
            .tabItem { Label("Devotional", systemImage: "music.note.list") }
            .tag(AppTab.devotional)

            PlaceholderTabView(
                title: "Explore",
                systemImage: "books.vertical",
                message: "Festivals, deities, stories, kids content, prasadam, fasting guides, and search will live here."
            )
            .tabItem { Label("Explore", systemImage: "books.vertical") }
            .tag(AppTab.explore)
        }
        .tint(DevotionalTheme.saffron)
    }
}

private struct PlaceholderTabView: View {
    let title: String
    let systemImage: String
    let message: String

    var body: some View {
        NavigationStack {
            ZStack {
                DevotionalTheme.ivory.ignoresSafeArea()

                VStack(spacing: 18) {
                    Image(systemName: systemImage)
                        .font(.system(size: 44, weight: .semibold))
                        .foregroundStyle(DevotionalTheme.saffron)
                        .accessibilityHidden(true)

                    Text(title)
                        .font(.title2.bold())
                        .foregroundStyle(DevotionalTheme.ink)

                    Text(message)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                }
                .padding(24)
            }
            .navigationTitle(title)
        }
    }
}

#Preview {
    AppRootView()
}
