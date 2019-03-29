//
//  AnalogClockView.swift
//  AnalogClock
//
//  Created by Justin Reusch on 3/14/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

@IBDesignable
class AnalogClockView: UIView, UpdatableClock, ReusableView {
    
    var contentView: UIView?
    @IBInspectable var nibName: String?
    
    // This will keep the current time, updated every second
    var time: CurrentTimeAndDate!
    
    // Clock hands
    @IBOutlet weak var hourHand: ClockHandView!
    @IBOutlet weak var minuteHand: ClockHandView!
    @IBOutlet weak var secondHand: ClockHandView!
    
    // Clock face
    @IBOutlet var clockFace: ClockFaceView!
    
    // Sets up time and pivot
    // Useful to call after required initializer has already run
    func setup(withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), andPivot pivot: Double = defaultClockPivot) {
        self.time = time
        setClockHands()
        setClockFace()
    }
    
    // Sets all three clock hand, hour, minute, second
    private func setClockHands(withPivot pivot: Double = defaultClockPivot) {
        guard let time = time else { return }
        hourHand?.setup(withController: ClockHandController(asType: .hour, withTime: time), andPivot: pivot)
        minuteHand?.setup(withController: ClockHandController(asType: .minute, withTime: time), andPivot: pivot)
        secondHand?.setup(withController: ClockHandController(asType: .second, withTime: time), andPivot: pivot)
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
        let rotations = "Hours: \(hourHand?.controller.rotation?.rounded() ?? 0)\u{00B0}, Minutes: \(minuteHand?.controller.rotation?.rounded() ?? 0)\u{00B0}, Seconds: \(secondHand?.controller.rotation?.rounded() ?? 0)\u{00B0}"
        print(rotations)
    }
    
    // Actions to take when an update is called for (driven by external timer which will call for periodic updates)
    func update() {
        
        // Sends update to all clock hands
        updateHands()
        
        // For testing... TODO: Remove this later
        printRotations()
        
    }
    
    // Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        loadView()
    }
    
    // Called when a designable object is created in Interface Builder.
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        prepareViewForInterfaceBuilder()
    }

}
