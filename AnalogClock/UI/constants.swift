//
//  constants.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/28/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

// Default pivot point for clock hands 0 = leading tip, 1 = end
let defaultClockPivot: Double = 0.85

let analogClockNibName = "AnalogClock"

// Dictionary to look up clock hand image names
let clockHandImageName: [ClockHandType:String] = [
    .twentyFourHour: "ClockHand_24Hour",
    .hour: "ClockHand_Hour",
    .minute: "ClockHand_Minute",
    .second: "ClockHand_Second"
]
