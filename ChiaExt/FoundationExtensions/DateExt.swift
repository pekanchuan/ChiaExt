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
