import SwiftUI

struct PanchangCalendarView: View {
    @Binding var secondaryLanguage: DevotionalLanguage

    @State private var visibleMonth = Date.now
    @State private var selectedDate = Date.now

    private let calendar = Calendar(identifier: .gregorian)
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)

    private var selectedPanchang: PanchangSummary {
        FestivalSampleData.panchang(for: selectedDate)
    }

    var body: some View {
        ZStack {
            DevotionalTheme.ivory.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: DevotionalTheme.contentSpacing) {
                    header
                    monthControls
                    weekdayHeader
                    monthGrid
                    selectedDayCard
                    referenceNotice
                }
                .padding(20)
            }
        }
        .navigationTitle("Calendar")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Panchang Calendar")
                .font(.largeTitle.bold())
                .foregroundStyle(DevotionalTheme.ink)
            if secondaryLanguage == .telugu {
                Text("పంచాంగ క్యాలెండర్")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.maroon)
            }
            Text("Daily Panchang fields are organized for devotional planning. Tampa, Florida is the default location.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var monthControls: some View {
        HStack(spacing: 12) {
            Button {
                moveMonth(by: -1)
            } label: {
                Image(systemName: "chevron.left")
            }
            .buttonStyle(SecondaryDevotionalButtonStyle())
            .accessibilityLabel("Previous month")

            VStack(spacing: 2) {
                Text(visibleMonth, format: .dateTime.month(.wide).year())
                    .font(.headline)
                    .foregroundStyle(DevotionalTheme.ink)
                if secondaryLanguage == .telugu {
                    Text("నెలను ఎంచుకోండి")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(DevotionalTheme.maroon)
                }
            }
            .frame(maxWidth: .infinity)

            Button {
                moveMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
            }
            .buttonStyle(SecondaryDevotionalButtonStyle())
            .accessibilityLabel("Next month")
        }
    }

    private var weekdayHeader: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(shortWeekdays, id: \.self) { weekday in
                Text(weekday)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private var monthGrid: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(monthDays) { day in
                if let date = day.date {
                    Button {
                        selectedDate = date
                    } label: {
                        VStack(spacing: 4) {
                            Text("\(calendar.component(.day, from: date))")
                                .font(.headline)
                            Circle()
                                .fill(isSelected(date) ? Color.white : DevotionalTheme.saffron.opacity(0.55))
                                .frame(width: 5, height: 5)
                        }
                        .foregroundStyle(isSelected(date) ? .white : DevotionalTheme.ink)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(
                            isSelected(date) ? DevotionalTheme.saffron : Color.white.opacity(0.48),
                            in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous)
                        )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(date.formatted(date: .complete, time: .omitted))
                } else {
                    Color.clear
                        .frame(minHeight: 52)
                }
            }
        }
    }

    private var selectedDayCard: some View {
        DevotionalCard {
            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(selectedDate, format: .dateTime.weekday(.wide).month(.wide).day().year())
                        .font(.title3.bold())
                        .foregroundStyle(DevotionalTheme.ink)
                    if secondaryLanguage == .telugu {
                        Text("ఎంచుకున్న రోజు పంచాంగం")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(DevotionalTheme.maroon)
                    }
                }

                PanchangCalendarSection(title: "Core Panchang", localizedTitle: teluguTitle("ప్రధాన పంచాంగం"))
                PanchangCalendarGrid(metrics: [
                    PanchangCalendarMetric(title: "Vara", localizedTitle: teluguTitle("వారం"), value: selectedPanchang.vara),
                    PanchangCalendarMetric(title: "Tithi", localizedTitle: teluguTitle("తిథి"), value: selectedPanchang.tithi),
                    PanchangCalendarMetric(title: "Paksha", localizedTitle: teluguTitle("పక్షం"), value: selectedPanchang.paksha),
                    PanchangCalendarMetric(title: "Nakshatra", localizedTitle: teluguTitle("నక్షత్రం"), value: selectedPanchang.nakshatra),
                    PanchangCalendarMetric(title: "Yoga", localizedTitle: teluguTitle("యోగం"), value: selectedPanchang.yoga),
                    PanchangCalendarMetric(title: "Karana", localizedTitle: teluguTitle("కరణం"), value: selectedPanchang.karana)
                ])

                PanchangCalendarSection(title: "Calendar Details", localizedTitle: teluguTitle("కాలగణన వివరాలు"))
                PanchangCalendarGrid(metrics: [
                    PanchangCalendarMetric(title: "Lunar Month", localizedTitle: teluguTitle("చాంద్ర మాసం"), value: selectedPanchang.lunarMonth),
                    PanchangCalendarMetric(title: "Amanta Masa", localizedTitle: teluguTitle("అమాంత మాసం"), value: selectedPanchang.amantaMasa),
                    PanchangCalendarMetric(title: "Purnimanta Masa", localizedTitle: teluguTitle("పూర్ణిమాంత మాసం"), value: selectedPanchang.purnimantaMasa),
                    PanchangCalendarMetric(title: "Solar Month", localizedTitle: teluguTitle("సౌర మాసం"), value: selectedPanchang.solarMonth),
                    PanchangCalendarMetric(title: "Ritu", localizedTitle: teluguTitle("ఋతువు"), value: selectedPanchang.ritu),
                    PanchangCalendarMetric(title: "Ayana", localizedTitle: teluguTitle("అయనం"), value: selectedPanchang.ayana),
                    PanchangCalendarMetric(title: "Samvatsara", localizedTitle: teluguTitle("సంవత్సరం"), value: selectedPanchang.samvatsara)
                ])

                PanchangCalendarSection(title: "Local Times", localizedTitle: teluguTitle("స్థానిక సమయాలు"))
                PanchangCalendarGrid(metrics: [
                    PanchangCalendarMetric(title: "Sunrise", localizedTitle: teluguTitle("సూర్యోదయం"), value: selectedPanchang.sunrise),
                    PanchangCalendarMetric(title: "Sunset", localizedTitle: teluguTitle("సూర్యాస్తమయం"), value: selectedPanchang.sunset),
                    PanchangCalendarMetric(title: "Moonrise", localizedTitle: teluguTitle("చంద్రోదయం"), value: selectedPanchang.moonrise),
                    PanchangCalendarMetric(title: "Moonset", localizedTitle: teluguTitle("చంద్రాస్తమయం"), value: selectedPanchang.moonset)
                ])
            }
        }
    }

    private var referenceNotice: some View {
        DevotionalCard {
            Text("Reference: Hindu Temple of Atlanta Panchang page was used only to understand expected Panchang categories. This app uses an original layout and does not copy temple branding, design, calendar data, or proprietary text.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private var shortWeekdays: [String] {
        calendar.shortWeekdaySymbols
    }

    private var monthDays: [CalendarDay] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: visibleMonth),
              let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end.addingTimeInterval(-1)) else {
            return []
        }

        var days: [CalendarDay] = []
        var current = firstWeek.start
        while current < lastWeek.end {
            let isInVisibleMonth = calendar.isDate(current, equalTo: visibleMonth, toGranularity: .month)
            days.append(CalendarDay(date: isInVisibleMonth ? current : nil))
            current = calendar.date(byAdding: .day, value: 1, to: current) ?? current.addingTimeInterval(86_400)
        }
        return days
    }

    private func moveMonth(by value: Int) {
        visibleMonth = calendar.date(byAdding: .month, value: value, to: visibleMonth) ?? visibleMonth
    }

    private func isSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }

    private func teluguTitle(_ title: String) -> String? {
        secondaryLanguage == .telugu ? title : nil
    }
}

private struct CalendarDay: Identifiable {
    let id = UUID()
    let date: Date?
}

private struct PanchangCalendarMetric: Identifiable {
    let id = UUID()
    let title: String
    let localizedTitle: String?
    let value: String
}

private struct PanchangCalendarSection: View {
    let title: String
    let localizedTitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(DevotionalTheme.saffron)
            if let localizedTitle {
                Text(localizedTitle)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(DevotionalTheme.maroon)
            }
        }
    }
}

private struct PanchangCalendarGrid: View {
    let metrics: [PanchangCalendarMetric]

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
            ForEach(metrics) { metric in
                VStack(alignment: .leading, spacing: 4) {
                    Text(metric.title)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                    if let localizedTitle = metric.localizedTitle {
                        Text(localizedTitle)
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(DevotionalTheme.maroon)
                    }
                    Text(metric.value)
                        .font(.subheadline)
                        .foregroundStyle(DevotionalTheme.ink)
                        .lineLimit(3)
                        .minimumScaleFactor(0.85)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(Color.white.opacity(0.46), in: RoundedRectangle(cornerRadius: DevotionalTheme.cardRadius, style: .continuous))
            }
        }
    }
}

private struct PanchangCalendarPreview: View {
    @State private var secondaryLanguage: DevotionalLanguage = .telugu

    var body: some View {
        NavigationStack {
            PanchangCalendarView(secondaryLanguage: $secondaryLanguage)
        }
    }
}

#Preview {
    PanchangCalendarPreview()
}
