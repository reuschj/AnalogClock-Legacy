//
//  UIClock.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/15/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class UIClock: UIView, UpdatableClock {
    
    // This will keep the current time, updated every second
    var time: CurrentTimeAndDate
    
    @IBOutlet weak var hourHand: UIClockHand!
    @IBOutlet weak var minuteHand: UIClockHand!
    @IBOutlet weak var secondHand: UIClockHand!
    
    let pivot = defaultClockPivot
    
    @IBOutlet weak var clockFace: UIClockFace!
    
    init(time: CurrentTimeAndDate, hourHand: UIClockHand, minuteHand: UIClockHand, secondHand: UIClockHand, withPivot pivot: Double = defaultClockPivot) {
        super.init(frame: CGRect.zero)
        self.time = time
        setClockHands(hour: hourHand, minute: minuteHand, second: secondHand)
    }
    
    convenience init(time: CurrentTimeAndDate = CurrentTimeAndDate()) {
        let hourHand = UIClockHand(controlledBy: ClockHandController(asType: .hour, withTime: time))
        let minuteHand = UIClockHand(controlledBy: ClockHandController(asType: .minute, withTime: time))
        let secondHand = UIClockHand(controlledBy: ClockHandController(asType: .second, withTime: time))
        self.init(time: time, hourHand: hourHand, minuteHand: minuteHand, secondHand: secondHand)
    }
    
    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        self.time = CurrentTimeAndDate()
        super.init(coder: aDecoder)
    }
    
    // Sets all three clock hand, hour, minute, second
    func setClockHands(hour: UIClockHand, minute: UIClockHand, second: UIClockHand) -> Void {
        hourHand = hour
        minuteHand = minute
        secondHand = second
        
        setClockHandControllers(withTime: time)
    }
    
    // Sets the clock hands with clock hand controllers
    private func setClockHandControllers(withTime: CurrentTimeAndDate) -> Void {
        hourHand.controller = ClockHandController(asType: .hour, withTime: time)
        minuteHand.controller = ClockHandController(asType: .minute, withTime: time)
        secondHand.controller = ClockHandController(asType: .second, withTime: time)
        
        hourHand.setClockHandPivot(to: pivot)
        minuteHand.setClockHandPivot(to: pivot)
        secondHand.setClockHandPivot(to: pivot)
    }
    
    // Actions to take when an update is called for (driven by external timer which will call for periodic updates)
    func update() {
        
        // Hand rotation test
        hourHand.setRotation(to: hourHand.controller?.rotationRadians)
        minuteHand.setRotation(to: minuteHand.controller?.rotationRadians)
        secondHand.setRotation(to: secondHand.controller?.rotationRadians)
        
        let testTimeReadout = "\(time.hour12 ?? 0):\(time.paddedMinute ?? "00"):\(time.paddedSecond ?? "00") \(time.period ?? "")"
        let testTimeReadout2 = "Hours: \(hourHand.controller?.rotation?.rounded() ?? 0)\u{00B0}, Minutes: \(minuteHand.controller?.rotation?.rounded() ?? 0)\u{00B0}, Seconds: \(secondHand.controller?.rotation?.rounded() ?? 0)\u{00B0}"
        
        let tickTock = time.tickTock
        if let tickTock = tickTock {
            switch tickTock {
            case .tick:
                tickLabel.text = tickTock.rawValue
                tockLable.text = ""
            case .tock:
                tickLabel.text = ""
                tockLable.text = tickTock.rawValue
            }
        }
        tempTimeDisplay.text = testTimeReadout
        tempTimeDisplay2.text = testTimeReadout2
        print(testTimeReadout)
        print(tickTock ?? "")
        print(testTimeReadout2)
    }
    
    
}
