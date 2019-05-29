//
//  DigitalClockView.swift
//  AnalogClock
//
//  Created by Justin Reusch on 3/29/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

@IBDesignable
class DigitalClockView: UIView, UpdatableClock, ReusableView {
    
    var contentView: UIView?
    @IBInspectable var nibName: String?
    
    // This will keep the current time, updated every second
    var time: CurrentTimeAndDate!
    
    // Sets type as 12-hour clock or 24-hour clock
    var type: ClockType = App.settings.clockType
    
    // The stack view of all time idcomponents
    @IBOutlet weak var timeDisplay: UIStackView!
    
    // Digital clock display parts
    @IBOutlet weak var hoursDisplay: DigitalDisplayComponent!
    @IBOutlet weak var minutesDisplay: DigitalDisplayComponent!
    @IBOutlet weak var secondsDisplay: DigitalDisplayComponent!
    @IBOutlet weak var periodDisplay: DigitalDisplayComponent!
    
    func setup(withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), andType clockType: ClockType) {
        self.time = time
        type = clockType
        setDigitalDisplay()
    }
    
    func setDigitalDisplay() {
        guard let time = time else { return }
        let hourDisplayType: ClockHandType = type == .twentyFourHour ? .twentyFourHour : .hour
        hoursDisplay?.text = "02"
        hoursDisplay?.setText("03")
        hoursDisplay?.setup(asType: hourDisplayType, withTime: time)
        minutesDisplay?.setup(asType: .minute, withTime: time)
        secondsDisplay?.setup(asType: .second, withTime: time)
        periodDisplay?.setup(asType: .period, withTime: time, width: CGFloat(40), height: CGFloat(30))
        periodDisplay?.isHidden = type == .twentyFourHour
    }
    
    func update() {
        hoursDisplay?.update()
        minutesDisplay?.update()
        secondsDisplay?.update()
        periodDisplay?.update()
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
