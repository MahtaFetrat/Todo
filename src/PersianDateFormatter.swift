import Foundation


class PersianDateFormatter {
    private static let dateFormatter: DateFormatter = getDateFormatter()

    private static func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.calendar = Calendar(identifier: .persian)

        return dateFormatter
    }

    static func parseDate(from: String) -> Date? {
        return PersianDateFormatter.dateFormatter.date(from: from)
    }


    static func currentDate() -> Date {
        return PersianDateFormatter.parseDate(from: dateFormatter.string(from: Date())) ?? Date()
    }
}
