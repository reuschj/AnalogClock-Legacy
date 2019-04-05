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
            let constraintWidth = isHiddenAndMinimized ? CGFloat(0) : preferredWidth
            widthAnchor.constraint(equalToConstant: constraintWidth).isActive = true

        }
    }
    
    func setText(_ textInput: String?) {
        text = textInput
    }
    
    static let defaultOrigin = CGPoint(x: 0, y: 0)
    static let defaultSize = CGSize(width: 54, height: 40)
    
    var preferredWidth: CGFloat = DigitalDisplayComponent.defaultSize.width
    var preferredHeight: CGFloat = DigitalDisplayComponent.defaultSize.height
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showAtInitialization()
    }

    convenience init(asType type: ClockHandType, withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), origin: CGPoint = DigitalDisplayComponent.defaultOrigin, size: CGSize = DigitalDisplayComponent.defaultSize) {
        self.init(frame: CGRect(origin: origin, size: size))
        setup(asType: type, withTime: time)
        showAtInitialization()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showAtInitialization()
    }
    
    func setup(asType type: ClockHandType, withTime time: CurrentTimeAndDate = CurrentTimeAndDate()) {
        self.type = type
        self.time = time
    }
    
    func setup(asType type: ClockHandType, withTime time: CurrentTimeAndDate = CurrentTimeAndDate(), width: CGFloat, height: CGFloat) {
        setup(asType: type, withTime: time)
        preferredWidth = width
        preferredHeight = height
    }

    func update() {
        text = getCurrentTime()
    }
    
    func getCurrentTime() -> String? {
        guard let type = type else { return nil }
        return type.getCurrentTime(fromTime: time)
    }
    
    func showAtInitialization() {
        isHidden = false
    }
    
    func show(_ makingVisible: Bool = true) {
        isHidden = !makingVisible
    }
    
    func hide(_ hidden: Bool = true) {
        isHidden = hidden
    }
}
