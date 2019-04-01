//
//  ClockHandController.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/5/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

let fullCircle: Double = 360

/**
 A class that holds type and rotation of clock hand
 */
class ClockHandController: TimeAware {
    let type: ClockHandType
    let time: CurrentTimeAndDate!
    var rotation: Double? {
        // Unwrap time elements
        guard let hour24 = time.hour24 else { return nil }
        guard let hour = time.hour12 else { return nil }
        guard let minute = time.minute else { return nil }
        guard let second = time.second else { return nil }
        guard let period = time.period else { return nil }
        guard let tickTock = time.tickTock else { return nil }
        // These are with fractions added from smaller increments
        let seconds = Double(second)
        let minutes = Double(minute) + seconds / 60
        let hours = Double(hour) + minutes / 60
        let hours24 = Double(hour24) + minutes / 60
        let period12: Double = hours / 12
        let period24: Double = hours24 / 24
        // Return the final calculation depending on the type
        switch type {
        case .twentyFourHour:
            return (period24 * fullCircle).truncatingRemainder(dividingBy: fullCircle)
        case .hour:
            return (period12 * fullCircle).truncatingRemainder(dividingBy: fullCircle)
        case .minute:
            return ((minutes / 60) * fullCircle).truncatingRemainder(dividingBy: fullCircle)
        case.second:
            return ((seconds / 60) * 360).truncatingRemainder(dividingBy: fullCircle)
        case .period:
            switch period {
            case .pm:
                return 1
            default:
                return 0
            }
        case .tickTock:
            switch tickTock {
            case .tock:
                return 1
            default:
                return 0
            }
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
