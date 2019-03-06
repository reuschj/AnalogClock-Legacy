//
//  AnalogClockView.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/15/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class AnalogClockView: UIView, UpdatableClock {
    
    // This will keep the current time, updated every second
    var time: CurrentTimeAndDate
    
    // Clock hands
    @IBOutlet var hourHand: ClockHandView!
    @IBOutlet var minuteHand: ClockHandView!
    @IBOutlet var secondHand: ClockHandView!
    
    // Clock face
    @IBOutlet var clockFace: ClockFaceView!
    
    @IBOutlet weak var testText: UILabel!
    
    // Initializer
    // Use this if you have already created hands and clock face in superview and need to pass them
    init(time: CurrentTimeAndDate, hourHand: ClockHandView, minuteHand: ClockHandView, secondHand: ClockHandView, clockFace: ClockFaceView) {
        self.time = time
        super.init(frame: CGRect.zero)
        self.hourHand = hourHand
        self.minuteHand = minuteHand
        self.secondHand = secondHand
        self.clockFace = clockFace
    }
    
    // Initializer
    // Use this to allow the initializer to create it's own hands and face
    init(time: CurrentTimeAndDate = CurrentTimeAndDate(), withPivot pivot: Double = defaultClockPivot) {
        self.time = time
        super.init(frame: CGRect.zero)
        setClockHands()
        setClockFace()
    }
    
    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        self.time = CurrentTimeAndDate()
        super.init(coder: aDecoder)
        setClockHands()
        setClockFace()
    }
    
    // Sets all three clock hand, hour, minute, second
    private func setClockHands(withPivot pivot: Double = defaultClockPivot) {
        hourHand = ClockHandView(controlledBy: ClockHandController(asType: .hour, withTime: time), withPivot: pivot)
        minuteHand = ClockHandView(controlledBy: ClockHandController(asType: .minute, withTime: time), withPivot: pivot)
        secondHand = ClockHandView(controlledBy: ClockHandController(asType: .second, withTime: time), withPivot: pivot)
    }
    
    // Sets the clock face image
    private func setClockFace() {
        // TODO: Better lookup
        clockFace = ClockFaceView(withImage: "ClockFace")
    }
    
    // Sends update to all clock hands
    private func updateHands() {
//        hourHand.update()
//        minuteHand.update()
//        secondHand.update()
        hourHand.setRotation(to: hourHand.rotationRadians)
        minuteHand.setRotation(to: minuteHand.rotationRadians)
        secondHand.setRotation(to: secondHand.rotationRadians)
        
        print("Rotation: \(secondHand.rotationRadians)")
        testText.text = "\(secondHand.rotationRadians)"
    }
    
    private func printRotations() {
        let rotations = "Hours: \(hourHand.controller.rotation?.rounded() ?? 0)\u{00B0}, Minutes: \(minuteHand.controller.rotation?.rounded() ?? 0)\u{00B0}, Seconds: \(secondHand.controller.rotation?.rounded() ?? 0)\u{00B0}"
        print(rotations)
    }
    
    // Actions to take when an update is called for (driven by external timer which will call for periodic updates)
    func update() {
        
        // Sends update to all clock hands
        updateHands()
        
        // For testing... TODO: Remove this later
        printRotations()
        
    }
    
    
}
