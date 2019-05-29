//
//  AnalogClockSetupp.swift
//  AnalogClock
//
//  Created by Justin Reusch on 4/5/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

// Stores dimensions and setup information for all hands of a clock
struct AnalogClockSetup {
    
    var hour: ClockHandDimensions
    var minute: ClockHandDimensions
    var second: ClockHandDimensions
    var face: ClockFaceView
    
    static let defaultShortHandRatio = UIAspectRatio(w: 76, h: 85)
    static let defaultLongHandRatio = UIAspectRatio(w: 32, h: 55)
    static let defaultClockPivotPoint = defaultClockPivot
    static let defaultClockFace = ClockFaceView(withImage: "ClockFace")
    
    // Initializer to build hands based on ratios
    init(
        hourHandRatio: UIAspectRatio = AnalogClockSetup.defaultShortHandRatio,
        minuteHandRatio: UIAspectRatio = AnalogClockSetup.defaultLongHandRatio,
        secondHandRatio: UIAspectRatio = AnalogClockSetup.defaultLongHandRatio,
        minuteHandScale: Double = 0.5,
        minuteToHourHandRatio: Double = 2,
        minuteToSecondHandRatio: Double = 1,
        pivot: Double = AnalogClockSetup.defaultClockPivotPoint,
        clockFace: ClockFaceView = AnalogClockSetup.defaultClockFace
    ) {
        
        // Calculates hour and second hand scales based on long hand
        let secondHandScale: Double = minuteHandScale / minuteToSecondHandRatio
        let hourHandScale: Double = minuteHandScale / minuteToHourHandRatio
        
        // Ensures pivot is within bounds
        let ifPivotOutOfBounds: Double = pivot > 1 ? 1 : 0
        let handPivot: Double = pivot >= 0 && pivot <= 1 ? pivot : ifPivotOutOfBounds
        
        hour = ClockHandDimensions(scale: hourHandScale, pivot: handPivot, aspectRatio: hourHandRatio)
        minute = ClockHandDimensions(scale: minuteHandScale, pivot: handPivot, aspectRatio: minuteHandRatio)
        second = ClockHandDimensions(scale: secondHandScale, pivot: handPivot, aspectRatio: secondHandRatio)
        face = clockFace
    }
    
    // Initializer for prebuilt hands
    init(hour: ClockHandDimensions, minute: ClockHandDimensions, second: ClockHandDimensions, face: ClockFaceView = AnalogClockSetup.defaultClockFace) {
        self.hour = hour
        self.minute = minute
        self.second = second
        self.face = face
    }
    
    // Creates a default clock dimension setup instance
    static func getDefault() -> AnalogClockSetup {
        return AnalogClockSetup(
            hourHandRatio: AnalogClockSetup.defaultShortHandRatio,
            minuteHandRatio: AnalogClockSetup.defaultLongHandRatio,
            secondHandRatio: AnalogClockSetup.defaultLongHandRatio,
            minuteHandScale: 0.5,
            minuteToHourHandRatio: 2,
            minuteToSecondHandRatio: 1,
            pivot: AnalogClockSetup.defaultClockPivotPoint,
            clockFace: AnalogClockSetup.defaultClockFace
        )
    }
}

