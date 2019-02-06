//
//  CurrentTimeAndDate.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/5/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

/**
 A class to hold a time and date that updates itself every second
 */
public class CurrentTimeAndDate {
    
    private var date: Date
    private let calendar: Calendar
    private var timer: Timer!
    private let interval: TimeInterval = defaultTickInterval
    private var dateComponents: DateComponents {
        return calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: date)
    }
    
    public var year: Int? {
        return dateComponents.year
    }
    public var month: Int? {
        return dateComponents.month
    }
    public var monthName: String? {
        guard let month = month else { return nil }
        let index = month - 1
        guard index >= 0 && index < monthNames.count else { return nil }
        return monthNames[index]
    }
    public var shortMonthName: String? {
        guard let month = month else { return nil }
        let index = month - 1
        guard index >= 0 && index < shortMonthNames.count else { return nil }
        return shortMonthNames[index]
    }
    public var day: Int? {
        return dateComponents.day
    }
    public var weekday: Int? {
        return dateComponents.weekday
    }
    public var dayOfWeek: String? {
        guard let weekday = weekday else { return nil }
        let index = weekday - 1
        guard index >= 0 && index < weekNames.count else { return nil }
        return weekNames[index]
    }
    public var shortDayOfWeek: String? {
        guard let weekday = weekday else { return nil }
        let index = weekday - 1
        guard index >= 0 && index < shortWeekNames.count else { return nil }
        return shortWeekNames[index]
    }
    public var hour: Int? {
        return dateComponents.hour
    }
    public var hour12: Int? {
        guard let hour = dateComponents.hour else { return nil }
        if hour == 0 {
            return 12
        } else if hour <= 12 {
            return hour
        } else {
            return hour % 12
        }
    }
    public var hour24: Int? {
        return dateComponents.hour
    }
    public var amPM: String? {
        guard let hour = dateComponents.hour else { return nil }
        return hour >= 0 && hour < 12 ? "AM" : "PM"
    }
    public var minute: Int? {
        return dateComponents.minute
    }
    public var second: Int? {
        return dateComponents.second
    }
    
    public init() {
        self.date = Date()
        self.calendar = Calendar.current
        self.timer = nil
        self.timer = Timer.scheduledTimer(withTimeInterval: self.interval, repeats: true, block: { [weak self] timer in
            self?.tick()
        })
    }
    
    // Called everytime the timer fires, this refreshes the date property with the current date
    private func tick() {
        date = Date()
    }
    
}
