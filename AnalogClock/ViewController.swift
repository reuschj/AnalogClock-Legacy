//
//  ViewController.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/4/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Timed {
    
    // This will keep the current time, updated every second
    let time: CurrentTimeAndDate = CurrentTimeAndDate()
    
    // This timer is for the view controller. It fires every second to check the current time
    var timer: Timer!
    
    // Analog clock display
    @IBOutlet var analogClock: UIClock!
    
    // Digital clock display
    // Temporary labels to show the test string printout of the time
    @IBOutlet weak var tempTimeDisplay: UILabel!
    @IBOutlet weak var tempTimeDisplay2: UILabel!
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
        analogClock.update()
    }
    
    // Loads after the view successfully loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        
        // Initialize the analog clock display
        analogClock = UIClock(time: time)
        
    }
        


}

