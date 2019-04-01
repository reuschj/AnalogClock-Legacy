//
//  MainViewController.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/4/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Timed, TimeAware {
    
    // This will keep the current time, updated every second
    let time: CurrentTimeAndDate! = CurrentTimeAndDate()
    
    // Clock type can be 12 or 24 hour
    var type: ClockType = .twelveHour
    
    // This timer is for the view controller. It fires every second to check the current time
    var timer: Timer!
    
    // Analog clock display
    @IBOutlet var analogClock: AnalogClockView!
    
    // Digital clock display
    @IBOutlet var digitalClock: DigitalClockView!
    
    // Temporary labels to show the test string printout of the time
    @IBOutlet weak var tempTimeDisplay: UILabel!
    @IBOutlet weak var tickLabel: UILabel!
    @IBOutlet weak var tockLable: UILabel!
    
    // Starts up the timer for the view controller
    private func startTimer() -> Void {
        
        // Sets the label on load
        actionOnTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: defaultTickInterval, repeats: true, block: { [weak self] timer in
            self?.actionOnTimer()
        })
    }
    
    // Defines the action(s) to run when the timer fires
    private func actionOnTimer() -> Void {
        
        // Update the analog and digtial clocks
        analogClock.update()
        digitalClock.update()
        
        // Update the digital clock
        let testTimeReadout = "\(time.hour12 ?? 0):\(time.paddedMinute ?? "00"):\(time.paddedSecond ?? "00") \(time.period?.rawValue ?? "")"
    
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
        print(testTimeReadout)
        print(tickTock ?? "")
    }
    
    // Loads after the view successfully loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the analog clock and digital clock displays
        analogClock.setup(withTime: time) // TODO: Add passing type to analog clock
        digitalClock.setup(withTime: time, andType: type)
        
        startTimer()
        
    }
        


}

