//
//  ViewController.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/4/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // This will keep the current time, updated every second
    let time: CurrentTimeAndDate = CurrentTimeAndDate()
    
    // This timer is for the view controller. It fires every second to check the current time
    var timer: Timer!
    
    // Clock hands
    @IBOutlet weak var hourHand: UIClockHand!
    @IBOutlet weak var minuteHand: UIClockHand!
    @IBOutlet weak var secondHand: UIClockHand!
    
    // Temporary label to show the test string printout of the time
    @IBOutlet weak var tempTimeDisplay: UILabel!
    @IBOutlet weak var tempTimeDisplay2: UILabel!
    @IBOutlet weak var tickLabel: UILabel!
    @IBOutlet weak var tockLable: UILabel!
    
    // Temporary function to get a test time readout... sets to the temp label and prints
    func getTestTimeReadout() {
        
        // Hand rotation test
        hourHand.setRotation(to: hourHand.controller?.rotationRadians)
        minuteHand.setRotation(to: minuteHand.controller?.rotationRadians)
        secondHand.setRotation(to: secondHand.controller?.rotationRadians)
        
        let testTimeReadout = "\(time.hour12 ?? 0):\(time.minute ?? 0):\(time.second ?? 0) \(time.period ?? "")"
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
    
    // Sets the clock hands with clock hand controllers
    private func setClockHandControllers(withTime: CurrentTimeAndDate) -> Void {
        hourHand.controller = ClockHandController(asType: .hour, withTime: time)
        minuteHand.controller = ClockHandController(asType: .minute, withTime: time)
        secondHand.controller = ClockHandController(asType: .second, withTime: time)
        
        let clockPivot = 0.85
        hourHand.setClockHandPivot(to: clockPivot)
        minuteHand.setClockHandPivot(to: clockPivot)
        secondHand.setClockHandPivot(to: clockPivot)
    }
    
    // Starts up the timer for the view controller
    private func startTimer() -> Void {
        
        // Sets the label on load
        actionOnTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: defaultTickInterval, repeats: true, block: { [weak self] timer in
            self?.actionOnTimer()
        })
    }
    
    // This maps to method/methods to run on timer
    private func actionOnTimer() -> Void {
        // TODO: Replace this
        getTestTimeReadout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setClockHandControllers(withTime: time)
        startTimer()
    }
        


}

