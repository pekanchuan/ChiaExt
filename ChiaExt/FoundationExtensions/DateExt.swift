//
//  DateExt.swift
//  ChiaExtDemo
//
//  Created by 贾发 on 2021/11/20.
//

import Foundation

// MARK: - Enums

extension Date {
    enum DayNameStyle {
        case threeLetters
        case oneLetter
        case full
    }
    
    enum MonthNameStyle {
        case threeLetters
        case oneLetter
        case full
    }
}

// MARK: - Properties

extension Date {
    var calendar: Calendar {
        Calendar(identifier: Calendar.current.identifier)
    }
    
    var era: Int {
        calendar.component(.era, from: self)
    }
    
    var weekOfYear: Int {
        calendar.component(.weekOfYear, from: self)
    }
    
    var weekOfMonth: Int {
        calendar.component(.weekOfMonth, from: self)
    }
    
    var year: Int {
        get {
            calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    
    var month: Int {
        get {
            calendar.component(.month, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    
    var day: Int {
        get {
            calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    
    var weekday: Int {
        calendar.component(.weekday, from: self)
    }
    
    var hour: Int {
        get {
            calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }
    
    var minute: Int {
        get {
            calendar.component(.minute, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }
    
    var second: Int {
        get {
            calendar.component(.second, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }
    
    var nanosecond: Int {
        get {
            calendar.component(.nanosecond, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds
            if let date = calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }
    
    var millisecond: Int {
        get {
            calendar.component(.nanosecond, from: self) / 1_000_000
        }
        set {
            let nanoSeconds = newValue * 1_000_000
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(nanoSeconds) else { return }
            
            if let date = calendar.date(byAdding: .nanosecond, value: nanoSeconds, to: self) {
                self = date
            }
        }
    }
    
    var isInFuture: Bool {
        self > Date()
    }
    
    var isInPast: Bool {
        self < Date()
    }
    
    var isInToday: Bool {
        calendar.isDateInToday(self)
    }
    
    var isInYesterday: Bool {
        calendar.isDateInYesterday(self)
    }
    
    var isInTomorrow: Bool {
        calendar.isDateInTomorrow(self)
    }
    
    var isInWeekend: Bool {
        calendar.isDateInWeekend(self)
    }
    
    var isWorkday: Bool {
        !calendar.isDateInWeekend(self)
    }
    
    var isInCurrentWeek: Bool {
        calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    var isInCurrentMonth: Bool {
        calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
    var isInCurrentYear: Bool {
        calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    var iso8601String: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    var yesterdat: Date {
        calendar.date(byAdding: .day, value: -1, to: self) ?? Date()
    }
    
    var tomorrow: Date {
        calendar.date(byAdding: .day, value: +1, to: self) ?? Date()
    }
    
    var unixTimestamp: Double {
        timeIntervalSince1970
    }
}

// MARK: - Methods

extension Date {
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }
    
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
    
    func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(value) else { return nil }
            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = value -  currentNanoseconds
            return calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self)
            
        case .second:
            guard let allowedRange = calendar.range(of: .second, in: .minute, for: self), allowedRange.contains(value) else { return nil }
            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = value - currentSeconds
            return calendar.date(byAdding: .second, value: secondsToAdd, to: self)
            
        case .minute:
            guard let allowedRange = calendar.range(of: .minute, in: .hour, for: self), allowedRange.contains(value) else { return nil }
            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = value - currentMinutes
            return calendar.date(byAdding: .minute, value: minutesToAdd, to: self)
            
        case .hour:
            guard let allowedRange = calendar.range(of: .hour, in: .day, for: self), allowedRange.contains(value) else { return nil }
            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = value - currentHour
            return calendar.date(byAdding: .hour, value: hoursToAdd, to: self)
            
        case .day:
            guard let allowedRange = calendar.range(of: .day, in: .month, for: self), allowedRange.contains(value) else { return nil }
            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = value - currentDay
            return calendar.date(byAdding: .day, value: daysToAdd, to: self)
            
        case .month:
            guard let allowedRange = calendar.range(of: .month, in: .year, for: self), allowedRange.contains(value) else { return nil }
            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = value - currentMonth
            return calendar.date(byAdding: .month, value: monthsToAdd, to: self)
            
        case .year:
            guard value > 0 else { return nil }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = value - currentYear
            return calendar.date(byAdding: .year, value: yearsToAdd, to: self)
            
        default:
            return calendar.date(bySetting: component, value: value, of: self)
        }
    }
    
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }
        
        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]
                
            case .minute:
                return [.year, .month, .day, .hour, .minute]
                
            case .hour:
                return [.year, .month, .day, .hour]
                
            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]
                
            case .month:
                return [.year, .month]
                
            case .year:
                return [.year]
                
            default:
                return []
            }
        }
        
        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }
    
    func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date
            
        case .minute:
            var date = adding(.minute, value: 1)
            let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .hour:
            var date = adding(.hour, value: 1)
            let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .day:
            var date = adding(.day, value: 1)
            date = calendar.startOfDay(for: date)
            date.add(.second, value: -1)
            return date
            
        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date
            
        case .month:
            var date = adding(.month, value: 1)
            let after = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .year:
            var date = adding(.year, value: 1)
            let after = calendar.date(from: calendar.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        default:
            return nil
        }
    }
    
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        calendar.isDate(self, equalTo: Date(), toGranularity: component)
    }
    
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }
    
    func dateName(ofStyle style: DayNameStyle = .full) -> String {
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .threeLetters:
                return "EEE"
            case .oneLetter:
                return "EEEEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    func monthName(ofStyle style: MonthNameStyle = .full) -> String {
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .threeLetters:
                return "MMM"
            case .oneLetter:
                return "MMMMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    func secondsSince(_ date: Date) -> Double {
        timeIntervalSince(date)
    }
    
    func minutesSince(_ date: Date) -> Double {
        timeIntervalSince(date) / 60
    }
    
    func hoursSince(_ date: Date) -> Double {
        timeIntervalSince(date) / 3600
    }
    
    func daysSince(_ date: Date) -> Double {
        timeIntervalSince(date) / (3600 * 24)
    }
    
    func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }
    
    func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = calendar.dateComponents([component], from: self, to: date)
        let componentValue = components.value(for: component)!
        return abs(componentValue) <= value
    }
    
    static func random(in range: Range<Date>) -> Date {
        Date(timeIntervalSinceReferenceDate: TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate ..< range.upperBound.timeIntervalSinceReferenceDate))
    }
    
    static func random(in range: ClosedRange<Date>) -> Date {
        Date(timeIntervalSinceReferenceDate: TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate ... range.upperBound.timeIntervalSinceReferenceDate))
    }
    
    static func random<T>(in range: Range<Date>, using generator: inout T) -> Date where T: RandomNumberGenerator {
        Date(timeIntervalSinceReferenceDate: TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate ..< range.upperBound.timeIntervalSinceReferenceDate, using: &generator))
    }
    
    static func random<T>(in range: ClosedRange<Date>, using generator: inout T) -> Date where T: RandomNumberGenerator {
        Date(timeIntervalSinceReferenceDate: TimeInterval.random(in: range.lowerBound.timeIntervalSinceReferenceDate ... range.upperBound.timeIntervalSinceReferenceDate, using: &generator))
    }
    
}
