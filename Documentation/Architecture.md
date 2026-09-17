# Hindu Devotional Platform Architecture

## Current Repository State

The project is currently a minimal SwiftUI app with:

- `HinduDevotional/HinduDevotional/ContentView.swift`
- `HinduDevotional/HinduDevotional/HinduDevotionalApp.swift`
- `Assets.xcassets`

The first implementation step should introduce a modular SwiftUI foundation while keeping the existing app lightweight.

## Apple API Direction

Local Apple documentation search confirms the architecture should use:

- SwiftUI `App` scene structure
- `TabView` for top-level app sections
- `NavigationStack` for stack navigation
- `NavigationSplitView` or adaptive `TabView` patterns for iPad later
- SwiftData for local persistence when models become user-editable
- async/await for service APIs
- MusicKit with `MusicAuthorization`, `MusicCatalogSearchRequest`, and required `NSAppleMusicUsageDescription`
- UserNotifications for reminder scheduling

Avoid `NavigationView`, Combine-heavy architecture, deprecated APIs, and global singleton state where dependency injection is clearer.

## iOS Architecture

Use a feature-first SwiftUI structure:

```text
HinduDevotional/
  App/
    HinduDevotionalApp.swift
    AppRootView.swift
    AppTab.swift
  DesignSystem/
    DevotionalColors.swift
    DevotionalTypography.swift
    DevotionalComponents.swift
  Models/
    Festival.swift
    Deity.swift
    Puja.swift
    Prayer.swift
    Panchang.swift
    SourceReference.swift
  Services/
    FestivalRepository.swift
    PanchangService.swift
    MusicService.swift
    NotificationService.swift
  Features/
    Home/
    Calendar/
    Puja/
    Devotional/
    Explore/
    FestivalDetail/
  Resources/
    SampleData/
```

### State Management

- Use `@State` for local view state.
- Use `@Observable` models/view models where shared screen state becomes useful.
- Use protocols for service boundaries.
- Use actors for shared mutable caches or network-backed repositories.
- Use SwiftData for local favorites, checklist state, family traditions, and preferences once persistence is introduced.

### Navigation

- `AppRootView` owns `TabView`.
- Each tab owns its own `NavigationStack`.
- Route values should be lightweight identifiers such as festival slug or deity ID, not full models.
- iPad can later adopt `NavigationSplitView` for master/detail calendar and Explore experiences.

### Content Loading

MVP should load bundled JSON/sample Swift data. Production should move toward:

1. Bundled fallback content for offline essentials.
2. API sync for reviewed/published content.
3. SwiftData cache for favorites, progress, and family content.
4. Content versioning for religious review updates.

## Website Architecture

Verified current public web stack direction:

- Next.js 16
- React 19.3
- Tailwind CSS v4
- TypeScript

Recommended structure:

```text
web/
  app/
    page.tsx
    today/page.tsx
    calendar/page.tsx
    festivals/[slug]/page.tsx
    puja/[slug]/page.tsx
    deities/page.tsx
    mantras/page.tsx
    music/page.tsx
    prasadam/page.tsx
    panchang/page.tsx
    kids/page.tsx
    search/page.tsx
    privacy/page.tsx
  components/
  lib/
    api.ts
    content.ts
    panchang.ts
  styles/
```

Use server components for content pages, client components for calendar interactivity, checklist state, media controls, search, and personalization.

## Backend Architecture

Recommended MVP-to-production path:

- Next.js API routes or a dedicated Node.js/TypeScript service for fast product iteration.
- PostgreSQL as the primary relational source of truth.
- Redis for caching Panchang responses, search suggestions, and notification jobs.
- Object storage for approved artwork/audio assets where licensed.
- CDN for static content and images.
- Search engine later: PostgreSQL full-text first, OpenSearch/Meilisearch when content grows.

### Service Boundaries

- Content service: festivals, deities, prayers, stories, recipes, sources, translations.
- Panchang service: provider abstraction, location-aware calculations/data provider responses.
- User service: preferences, favorites, family traditions.
- Notification service: festival reminders, checklist reminders, puja window alerts.
- Music service: provider links, Apple Music catalog integration, playlist metadata.
- Review service: workflow, flags, reviewer notes, publishing gates.

## Panchang Architecture

Panchang must be provider-driven:

```text
PanchangProvider
  getDailyPanchang(date, location, tradition)
  getFestivalOccurrences(year, location, tradition, filters)
  getPujaWindows(festival, date, location, tradition)
```

The app should display:

- Tithi
- Nakshatra
- Yoga
- Karana
- Paksha
- Hindu month
- Sunrise/sunset
- Moonrise/moonset
- Rahu Kalam
- Yamagandam
- Gulika Kalam
- Abhijit Muhurta when applicable
- Festival-specific puja windows when available

Every Panchang screen should include a variation notice: festival timing may vary by location and tradition.

## MusicKit Architecture

Music functionality should be legal and provider-based:

```text
MusicService
  requestAuthorization()
  search(term)
  openInProvider(item)
  playPreviewOrCatalogItem(item)
  createPlaylist(name, items)
```

Implementation rules:

- Request MusicKit authorization only when the user starts music actions.
- Add `NSAppleMusicUsageDescription` before using MusicKit.
- Check subscription capabilities before playback or library modification.
- Respect Apple artwork display rules.
- Do not host copyrighted recordings without license.
- Store provider IDs/links, not copied audio.

## Notification Architecture

Reminder types:

- Festival countdown
- Checklist task
- Vrat tomorrow
- Puja window begins soon
- Ekadashi/Pradosham/Sankashti observance
- Family tradition reminder

Scheduling rules:

- Ask permission contextually.
- Let users disable all notifications or specific categories.
- Recompute when location, timezone, tradition, or calendar provider changes.
- Avoid claiming exact muhurta unless provider data exists.

## Localization Architecture

Supported languages:

- English
- Telugu
- Hindi
- Tamil
- Kannada
- Malayalam
- Sanskrit
- Marathi
- Gujarati
- Bengali

Each prayer/mantra should support:

- Original script
- Transliteration
- Meaning
- Optional word-by-word explanation
- Language
- Translator
- Source
- Review status

UI strings should use platform localization. Content translations should be stored as content records with review metadata.

## Content Review Workflow

Statuses:

- Draft
- Researching
- Tradition reviewed
- Language reviewed
- Published

Flags:

- Incorrect mantra
- Incorrect pronunciation
- Wrong deity association
- Regional difference
- Incorrect festival timing
- Translation issue
- Source missing
- Copyright concern

Publishing rules:

- Mantras and Sankalpam templates cannot publish without source and reviewer metadata.
- Festival dates cannot publish without provider/source metadata.
- Translations must identify translator or licensed source.
- Community/family traditions must be labeled distinctly.

## Security And Privacy

- Use least-privilege API tokens.
- Store secrets server-side only.
- Encrypt sensitive user data at rest where applicable.
- Treat location as optional and purpose-bound.
- Make family traditions private by default.
- Use signed URLs for private media uploads.
- Audit admin/reviewer actions.

## Deployment Architecture

Recommended production shape:

```text
iOS App
  -> Backend API
  -> PostgreSQL
  -> Redis
  -> Object Storage/CDN
  -> Panchang Provider
  -> Apple Music / Spotify / YouTube links

Website
  -> Same Backend API
  -> Static/server-rendered content pages
```

## Incremental Build Plan

1. Create SwiftUI app shell with five tabs.
2. Add design system and sample data models.
3. Build Home dashboard.
4. Build Ganesh Chaturthi detail.
5. Build checklist and Puja Mode.
6. Add Calendar shell and Panchang provider abstraction.
7. Add Devotional/Music shell.
8. Add Explore and search scaffolding.
9. Add local persistence for favorites/checklist.
10. Add backend/web projects after iOS prototype proves the content model.
