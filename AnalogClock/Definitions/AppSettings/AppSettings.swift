//
//  AppSettings.swift
//  AnalogClock
//
//  Created by Justin Reusch on 5/28/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

// Class to hold app state object for app settings
class AppSettings {
    
    // Static variables for global settings
    static var theme: AppTheme = .light
    static var clockType: ClockType = .twelveHour
    static var hasAnalogClock: Bool = true
    static var hasDigitalClock: Bool = true
    static var hasDateDisplay: Bool = true
    static var clockHandSetup: AnalogClockSetup = AnalogClockSetup.getDefault()
    
    // Instance variables for local settings or creating instances on the app delegate
    var theme: AppTheme = .light
    var clockType: ClockType = .twelveHour
    var hasAnalogClock: Bool = true
    var hasDigitalClock: Bool = true
    var hasDateDisplay: Bool = true
    var clockHandSetup: AnalogClockSetup = AnalogClockSetup.getDefault()
    
    // Initializer
    init(theme: AppTheme = .light, clockType: ClockType = .twelveHour, hasAnalogClock: Bool = true, hasDigitalClock: Bool = true, hasDateDisplay: Bool = true, clockHandSetup: AnalogClockSetup = ClockDimensionSetup.default()) {
        self.theme = theme
        self.clockType = clockType
        self.hasAnalogClock = hasAnalogClock
        self.hasDigitalClock = hasDigitalClock
        self.hasDateDisplay = hasDateDisplay
        self.clockHandSetup = clockHandSetup
    }
}
