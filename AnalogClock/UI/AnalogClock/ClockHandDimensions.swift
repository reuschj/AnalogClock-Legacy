//
//  ClockHandDimensions.swift
//  AnalogClock
//
//  Created by Justin Reusch on 4/5/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

// Stores dimesions for a clock hand
struct ClockHandDimensions {
    
    let scale: Double
    let pivot: Double
    let aspectRatio: UIAspectRatio?
    
    init(scale: Double = 1, pivot: Double = defaultClockPivot, aspectRatio: UIAspectRatio? = nil) {
        func inRange(_ x: Double) -> Bool { return x >= 0 && x <= 1 }
        self.scale = inRange(scale) ? scale : 1
        self.pivot = inRange(pivot) ? pivot : defaultClockPivot
        self.aspectRatio = aspectRatio
    }
    
}


