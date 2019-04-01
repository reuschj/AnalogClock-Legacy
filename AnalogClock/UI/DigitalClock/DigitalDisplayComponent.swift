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
    
    private var isHiddenAndMinimized = false
    override var isHidden: Bool {
        get {
            return isHiddenAndMinimized
        }
        set {
            isHiddenAndMinimized = newValue
        }
    }
    
    static let defaultOrigin = CGPoint(x: 0, y: 0)
    static let defaultSize = CGSize(width: 48, height: 40)
    
    var width: CGFloat {
        get {
            return bounds.width
        }
        set {
            let scaleAmount: CGFloat = newValue / bounds.width
            let newSize: CGRect = bounds.applying(CGAffineTransform(scaleX: scaleAmount, y: 0))
            bounds = newSize
        }
    }
    var height: CGFloat {
        get {
            return bounds.height
        }
        set {
            let scaleAmount: CGFloat = newValue / bounds.height
            let newSize: CGRect = bounds.applying(CGAffineTransform(scaleX: 0, y: scaleAmount))
            bounds = newSize
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(asType type: ClockHandType, withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), origin: CGPoint = DigitalDisplayComponent.defaultOrigin, size: CGSize = DigitalDisplayComponent.defaultSize) {
        self.init(frame: CGRect(origin: origin, size: size))
        setup(asType: type, withTime: time)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(asType type: ClockHandType, withTime time: CurrentTimeAndDate = CurrentTimeAndDate()) {
        self.type = type
        self.time = time
    }
    
    func setup(asType type: ClockHandType, withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), width: CGFloat = DigitalDisplayComponent.defaultSize.width, height: CGFloat = DigitalDisplayComponent.defaultSize.height) {
        setup(asType: type, withTime: time)
        self.width = width
        self.height = height
    }

    func update() {
        text = getCurrentTime()
    }
    
    func getCurrentTime() -> String? {
        guard let type = type else { return nil }
        return type.getCurrentTime(fromTime: time)
    }
    
    func show(_ makingVisible: Bool = true) {
        if (makingVisible) {
            guard isHidden else { return }
            isHidden = false
            widthAnchor.constraint(equalToConstant: width)
        } else {
            guard !isHidden else { return }
            isHidden = true
            widthAnchor.constraint(equalToConstant: 0)
        }
    }
    
    func hide(_ hidden: Bool = true) {
        show(!hidden)
    }
}
