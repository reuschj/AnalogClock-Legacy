//
//  UIClock.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/15/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class UIClock: UIView {
    
    // This will keep the current time, updated every second
    var time: CurrentTimeAndDate! = nil
    
    var hourHand: UIClockHand! = nil
    var minuteHand: UIClockHand! = nil
    var secondHand: UIClockHand! = nil
    
    init(time: CurrentTimeAndDate, hourHand: UIClockHand, minuteHand: UIClockHand, secondHand: UIClockHand) {
        self.time = time
        self.hourHand = hourHand
        self.minuteHand = minuteHand
        self.secondHand = secondHand
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
