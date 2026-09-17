import Foundation

struct DefaultLocation: Hashable {
    let name: String
    let latitude: Double
    let longitude: Double
    let timeZone: TimeZone

    static let tampaFlorida = DefaultLocation(
        name: "Tampa, Florida",
        latitude: 27.9506,
        longitude: -82.4572,
        timeZone: TimeZone(identifier: "America/New_York") ?? .current
    )
}

struct SolarTimes: Hashable {
    let sunrise: Date?
    let sunset: Date?
}

enum SolarTimeCalculator {
    static func solarTimes(on date: Date, at location: DefaultLocation) -> SolarTimes {
        SolarTimes(
            sunrise: solarEvent(on: date, at: location, isSunrise: true),
            sunset: solarEvent(on: date, at: location, isSunrise: false)
        )
    }

    static func formattedSolarTimes(on date: Date, at location: DefaultLocation) -> (sunrise: String, sunset: String) {
        let times = solarTimes(on: date, at: location)
        let formatter = DateFormatter()
        formatter.timeZone = location.timeZone
        formatter.timeStyle = .short
        formatter.dateStyle = .none

        return (
            times.sunrise.map { formatter.string(from: $0) } ?? "Unavailable",
            times.sunset.map { formatter.string(from: $0) } ?? "Unavailable"
        )
    }

    private static func solarEvent(on date: Date, at location: DefaultLocation, isSunrise: Bool) -> Date? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = location.timeZone

        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1
        let longitudeHour = location.longitude / 15.0
        let approximateTime = Double(dayOfYear) + ((isSunrise ? 6.0 : 18.0) - longitudeHour) / 24.0
        let meanAnomaly = (0.9856 * approximateTime) - 3.289

        var trueLongitude = meanAnomaly
            + (1.916 * sin(degreesToRadians(meanAnomaly)))
            + (0.020 * sin(degreesToRadians(2 * meanAnomaly)))
            + 282.634
        trueLongitude = normalizedDegrees(trueLongitude)

        var rightAscension = radiansToDegrees(atan(0.91764 * tan(degreesToRadians(trueLongitude))))
        rightAscension = normalizedDegrees(rightAscension)

        let longitudeQuadrant = floor(trueLongitude / 90.0) * 90.0
        let rightAscensionQuadrant = floor(rightAscension / 90.0) * 90.0
        rightAscension = (rightAscension + longitudeQuadrant - rightAscensionQuadrant) / 15.0

        let sinDeclination = 0.39782 * sin(degreesToRadians(trueLongitude))
        let cosDeclination = cos(asin(sinDeclination))
        let zenith = 90.833
        let latitudeRadians = degreesToRadians(location.latitude)

        let cosHourAngle = (cos(degreesToRadians(zenith)) - (sinDeclination * sin(latitudeRadians))) / (cosDeclination * cos(latitudeRadians))
        guard cosHourAngle >= -1, cosHourAngle <= 1 else {
            return nil
        }

        var hourAngle = isSunrise
            ? 360.0 - radiansToDegrees(acos(cosHourAngle))
            : radiansToDegrees(acos(cosHourAngle))
        hourAngle /= 15.0

        let localMeanTime = hourAngle + rightAscension - (0.06571 * approximateTime) - 6.622
        let universalTime = normalizedHours(localMeanTime - longitudeHour)

        guard let utcDate = utcDate(for: date, hour: universalTime) else {
            return nil
        }

        return utcDate
    }

    private static func utcDate(for date: Date, hour: Double) -> Date? {
        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .gmt

        var localCalendar = Calendar(identifier: .gregorian)
        localCalendar.timeZone = .current

        let localComponents = localCalendar.dateComponents([.year, .month, .day], from: date)
        let wholeHour = Int(hour)
        let minuteFraction = (hour - Double(wholeHour)) * 60.0
        let minute = Int(minuteFraction)
        let second = Int((minuteFraction - Double(minute)) * 60.0)

        var components = DateComponents()
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.year = localComponents.year
        components.month = localComponents.month
        components.day = localComponents.day
        components.hour = wholeHour
        components.minute = minute
        components.second = second

        return utcCalendar.date(from: components)
    }

    private static func degreesToRadians(_ degrees: Double) -> Double {
        degrees * .pi / 180.0
    }

    private static func radiansToDegrees(_ radians: Double) -> Double {
        radians * 180.0 / .pi
    }

    private static func normalizedDegrees(_ degrees: Double) -> Double {
        let value = degrees.truncatingRemainder(dividingBy: 360.0)
        return value < 0 ? value + 360.0 : value
    }

    private static func normalizedHours(_ hours: Double) -> Double {
        let value = hours.truncatingRemainder(dividingBy: 24.0)
        return value < 0 ? value + 24.0 : value
    }
}
