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
    
    // Sets type as 12-hour clock or 24-hour clock
    var type: ClockType!
    
    // Clock hands
    @IBOutlet weak var hourHand: ClockHandView!
    @IBOutlet weak var minuteHand: ClockHandView!
    @IBOutlet weak var secondHand: ClockHandView!
    
    // Clock face
    @IBOutlet var clockFace: ClockFaceView!
    
    static private let defaultMinuteToHourHandRatio: Double = 2
    static private let defaultMinuteToSecondHandRatio: Double = 1
    static private let defaultMinuteHandScale: Double = 0.5
    static private var defaultSecondHandScale: Double {
        return defaultMinuteHandScale / defaultMinuteToSecondHandRatio
    }
    static private var defaultHourHandScale: Double {
        return defaultMinuteHandScale / defaultMinuteToHourHandRatio
    }
    static private var defaultHandPivot: Double { return defaultClockPivot }
    static private var defaultClockDimensionSetup: ClockDimensionSetup {
        let hourHandRatio = UIAspectRatio(width: 76, height: 85)
        let longHandRatio = UIAspectRatio(width: 32, height: 55)
        let hourHandDimensions = ClockHandDimensions(scale: AnalogClockView.defaultHourHandScale, pivot: AnalogClockView.defaultHandPivot, aspectRatio: hourHandRatio)
        let minuteHandDimensions = ClockHandDimensions(scale: AnalogClockView.defaultMinuteHandScale, pivot: AnalogClockView.defaultHandPivot, aspectRatio: longHandRatio)
        let secondHandDimensions = ClockHandDimensions(scale: AnalogClockView.defaultSecondHandScale, pivot: AnalogClockView.defaultHandPivot, aspectRatio: longHandRatio)
        return ClockDimensionSetup(hour: hourHandDimensions, minute: minuteHandDimensions, second: secondHandDimensions)
    }
    
    // Sets up time and pivot
    // Useful to call after required initializer has already run
    func setup(withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), andType type: ClockType = .twelveHour, andPivot pivot: Double = defaultClockPivot) {
        self.time = time
        self.type = type
        setClockHands()
        setClockFace()
    }
    
    // Sets up time and pivot with default type
    func setup(withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), andPivot pivot: Double = defaultClockPivot) {
        setup(withTime: time, andType: .twelveHour, andPivot: pivot)
    }
    
    // Sets all three clock hand, hour, minute, second
    private func setClockHands(withPivot pivot: Double = defaultClockPivot) {
        guard let time = time else { return }
        let hourHandRatio = UIAspectRatio(width: 76, height: 85)
        let longHandRatio = UIAspectRatio(width: 32, height: 55)
        // TODO: Setup with setup objects
        let hourHandType: ClockHandType = type == ClockType.twentyFourHour ? .twentyFourHour : .hour
        hourHand?.setup(withController: ClockHandController(asType: hourHandType, withTime: time), andPivot: pivot, toAspectRatio: hourHandRatio)
        minuteHand?.setup(withController: ClockHandController(asType: .minute, withTime: time), andPivot: pivot, toAspectRatio: longHandRatio)
        secondHand?.setup(withController: ClockHandController(asType: .second, withTime: time), andPivot: pivot, toAspectRatio: longHandRatio)
        hourHand?.setScale(to: 0.3)
        minuteHand?.setScale(to: 0.5)
        secondHand?.setScale(to: 0.5)
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
