//
//  DigitalDisplayComponent.swift
//  AnalogClock
//
//  Created by Justin Reusch on 3/30/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class DigitalDisplayComponent: UILabel, Updatable, TimeAware {
    
    var time: CurrentTimeAndDate!
    
    var type: ClockHandType?
    
    var preferredWidth: CGFloat = 48
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(asType type: ClockHandType, withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), andPreferredWidth preferredWidth: Int = 48) {
        self.type = type
        self.time = time
        self.preferredWidth = CGFloat(preferredWidth)
    }

    func update() {
        text = getCurrentTime()
    }
    
    func getCurrentTime() -> String? {
        guard let type = type else { return nil }
        switch type {
        case .twentyFourHour:
            return time?.hour24String
        case .hour:
            return time?.hour12String
        case .minute:
            return time?.paddedMinute
        case .second:
            return time?.paddedSecond
        default:
            guard let period = time?.period else { return nil }
            return period.rawValue
        }
    }
    
    func show(_ visible: Bool = true) {
        if (visible) {
            isHidden = false
            widthAnchor.constraint(equalToConstant: preferredWidth)
        } else {
            isHidden = true
            widthAnchor.constraint(equalToConstant: 0)
        }
    }
    
    func hide(_ hidden: Bool = true) {
        show(!hidden)
    }
}
