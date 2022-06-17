import Foundation


class DateFormatUtils {
    private static let dateFormatter: DateFormatter = getDateFormatter()

    private static func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter
    }

    static func parseDate(from: String) -> Date? {
        return DateFormatUtils.dateFormatter.date(from: from)
    }

    static func currentDate() -> Date {
        return DateFormatUtils.parseDate(from: dateFormatter.string(from: Date())) ?? Date()
    }

    static func toString(date: Date) -> String { 
        return DateFormatUtils.dateFormatter.string(from: date)
    }

    static func compare(this: Date, other: Date) -> ComparisonResult {
        return  Calendar.current.compare(this, to: other, toGranularity: .day)
    }
}
