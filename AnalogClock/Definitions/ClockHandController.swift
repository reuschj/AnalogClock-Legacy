//
//  ClockHandController.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/5/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

/**
 A class that holds type and rotation of clock hand
 */
class ClockHandController {
    let type: ClockHandType
    let time: CurrentTimeAndDate
    var rotation: Double? {
        // Unwrap time elements
        guard let hour24 = time.hour24 else { return nil }
        guard let hour = time.hour12 else { return nil }
        guard let minute = time.minute else { return nil }
        guard let second = time.second else { return nil }
        // These are with fractions added from smaller increments
        let seconds = Double(second)
        let minutes = Double(minute) + seconds / 60
        let hours = Double(hour) + minutes / 60
        let hours24 = Double(hour24) + minutes / 60
        let period: Double = hours / 12
        let period24: Double = hours24 / 24
        // Return the final calculation depending on the type
        switch type {
        case .twentyFourHour:
            return period24 * 360
        case .hour:
            return period * 360
        case .minute:
            return (minutes / 60) * 360
        case.second:
            return (seconds / 60) * 360
        }
    }
    var rotationRadians: Double? {
        guard let rotationInDegrees = rotation else { return nil }
        return rotationInDegrees * Double.pi / 180
    }
    
    init(asType type: ClockHandType, withTime time: CurrentTimeAndDate) {
        self.type = type
        self.time = time
    }
}
