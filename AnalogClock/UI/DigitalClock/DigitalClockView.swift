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
    
    // Digital clock display parts
    @IBOutlet weak var hoursDisplay: UILabel!
    @IBOutlet weak var minutesDisplay: UILabel!
    @IBOutlet weak var secondsDisplay: UILabel!
    @IBOutlet weak var periodDisplay: UILabel!
    
    func setup(withTime time: CurrentTimeAndDate = CurrentTimeAndDate()) {
        self.time = time
    }
    
    func update() {
        // TODO: Write update code
//        hoursDisplay?.update()
//        minutesDisplay?.update()
//        secondsDisplay?.update()
//        periodDisplay?.update()
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
