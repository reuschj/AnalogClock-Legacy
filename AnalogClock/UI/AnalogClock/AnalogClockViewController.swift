//
//  AnalogClockViewController.swift
//  AnalogClock
//
//  Created by Justin Reusch on 3/11/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class AnalogClockViewController: UIViewController, UpdatableClock {
    
    // This will keep the current time, updated every second
    var time: CurrentTimeAndDate!
    
    // Clock hands
    @IBOutlet weak var hourHand: ClockHandView!
    @IBOutlet weak var minuteHand: ClockHandView!
    @IBOutlet var secondHand: ClockHandView!
    
    // Clock face
    @IBOutlet var clockFace: ClockFaceView!
    
    // Initializer
    // Use this if you have already created hands and clock face in superview and need to pass them
    init(time: CurrentTimeAndDate, hourHand: ClockHandView, minuteHand: ClockHandView, secondHand: ClockHandView, clockFace: ClockFaceView) {
        super.init(nibName: analogClockNibName, bundle: Bundle(for: type(of: self)))
        setup(withTime: time, hourHand: hourHand, minuteHand: minuteHand, secondHand: secondHand, clockFace: clockFace)
    }
    
    // Initializer
    // Use this to allow the initializer to create it's own hands and face
    init(time: CurrentTimeAndDate = CurrentTimeAndDate(), withPivot pivot: Double = defaultClockPivot) {
        super.init(nibName: analogClockNibName, bundle: Bundle(for: type(of: self)))
        setup(withTime: time, andPivot: pivot)
    }
    
    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        self.time = nil
        super.init(coder: aDecoder)
    }
    
    
    
    // Sets up time and pivot
    // Useful to call after required initializer has already run
    func setup(withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), andPivot pivot: Double = defaultClockPivot) {
        self.time = time
        setClockHands(withPivot: pivot)
        setClockFace()
    }
    
    // Sets up time and pivot
    // Useful to call after required initializer has already run
    func setup(withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), hourHand: ClockHandView, minuteHand: ClockHandView, secondHand: ClockHandView, clockFace: ClockFaceView) {
        self.time = time
        self.hourHand = hourHand
        self.minuteHand = minuteHand
        self.secondHand = secondHand
        self.clockFace = clockFace
    }
    
    // Allows view to be displayed in Interface Builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadView()
        view?.prepareForInterfaceBuilder()
    }
    
    // Sets all three clock hand, hour, minute, second
    private func setClockHands(withPivot pivot: Double = defaultClockPivot) {
        guard let time = time else { return }
        hourHand?.setup(withController: ClockHandController(asType: .hour, withTime: time), andPivot: pivot)
        minuteHand?.setup(withController: ClockHandController(asType: .minute, withTime: time), andPivot: pivot)
        secondHand?.setup(withController: ClockHandController(asType: .second, withTime: time), andPivot: pivot)
        //        hourHand = ClockHandView(controlledBy: ClockHandController(asType: .hour, withTime: time), withPivot: pivot)
        //        minuteHand = ClockHandView(controlledBy: ClockHandController(asType: .minute, withTime: time), withPivot: pivot)
        //        secondHand = ClockHandView(controlledBy: ClockHandController(asType: .second, withTime: time), withPivot: pivot)
    }
    
    // Sets the clock face image
    private func setClockFace() {
        // TODO: Better lookup
        clockFace = ClockFaceView(withImage: "ClockFace")
    }
    
    // Sends update to all clock hands
    private func updateHands() {
        hourHand?.update()
        minuteHand?.update()
        secondHand?.update()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()

        // Do any additional setup after loading the view.
    }

}
