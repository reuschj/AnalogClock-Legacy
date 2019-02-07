//
//  ViewController.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/4/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Temporary label to show the test string printout of the time
    @IBOutlet weak var tempTimeDisplay: UILabel!
    @IBOutlet weak var tempTimeDisplay2: UILabel!
    @IBOutlet weak var tickLabel: UILabel!
    @IBOutlet weak var tockLable: UILabel!
    
    // This will keep the current time, updated every second
    let time: CurrentTimeAndDate = CurrentTimeAndDate()
    
    // This timer is for the view controller. It fires every second to check the current time
    var timer: Timer!
    
    // Temporary for testing
    var hourHand: ClockHand! = nil
    var minuteHand: ClockHand! = nil
    var secondHand: ClockHand! = nil
    
    // Temporary function to get a test time readout... sets to the temp label and prints
    func getTestTimeReadout() {
        let testTimeReadout = "\(self.time.hour12 ?? 0):\(self.time.minute ?? 0):\(self.time.second ?? 0) \(self.time.period ?? "")"
        let testTimeReadout2 = "Hours: \(self.hourHand.rotation?.rounded() ?? 0), Minutes: \(self.minuteHand.rotation?.rounded() ?? 0), Seconds: \(self.secondHand.rotation?.rounded() ?? 0)"
        let tickTock = self.time.tickTock
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Temporary for testing
        self.hourHand = ClockHand(asType: .hour, withTime: time)
        self.minuteHand = ClockHand(asType: .minute, withTime: time)
        self.secondHand = ClockHand(asType: .second, withTime: time)
        
        // Sets the label on load
        self.getTestTimeReadout()
        
        // Sets up the timer on load
        self.timer = Timer.scheduledTimer(withTimeInterval: defaultTickInterval, repeats: true, block: { [weak self] timer in
            self?.getTestTimeReadout()
        })
    }
        


}

