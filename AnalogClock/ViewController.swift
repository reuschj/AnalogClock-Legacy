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
    
    // This will keep the current time, updated every second
    let time: CurrentTimeAndDate = CurrentTimeAndDate()
    
    // This timer is for the view controller. It fires every second to check the current time
    var timer: Timer!
    
    // Temporary function to get a test time readout... sets to the temp label and prints
    func getTestTimeReadout() {
        let testTimeReadout = "The time is \(self.time.hour12 ?? 0):\(self.time.minute ?? 0):\(self.time.second ?? 0) \(self.time.amPM ?? "")"
        tempTimeDisplay.text = testTimeReadout
        print(testTimeReadout)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the label on load
        self.getTestTimeReadout()
        
        // Sets up the timer on load
        self.timer = Timer.scheduledTimer(withTimeInterval: defaultTickInterval, repeats: true, block: { [weak self] timer in
            self?.getTestTimeReadout()
        })
    }
        


}

