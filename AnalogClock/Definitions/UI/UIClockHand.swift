//
//  UIClockHand.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/6/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

/**
 UI Image View to control clock hands
 */
class UIClockHand: UIImageView {
    
    var controller: ClockHandController
    var type: ClockHandType {
        return controller.type
    }
    var time: CurrentTimeAndDate {
        return controller.time
    }
    
    init(withImage imageName: String, controlledBy controller: ClockHandController) {
        self.controller = controller
        let image = UIImage(named: imageName)
        super.init(image: image)
    }
    
    init(controlledBy controller: ClockHandController) {
        self.controller = controller
        let image = UIClockHand.getClockHandImage(withType: controller.type)
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.controller = ClockHandController(asType: .hour, withTime: CurrentTimeAndDate())
        super.init(coder: aDecoder)
    }
    
    static func getClockHandImage(withType type: ClockHandType) -> UIImage? {
        var imageName = ""
        switch type {
        case .twentyFourHour:
            imageName = clockHandImageName[.twentyFourHour] ?? "ClockHand_Hour24"
        case .hour:
            imageName = clockHandImageName[.hour] ?? "ClockHand_Hour"
        case .minute:
            imageName = clockHandImageName[.minute] ?? "ClockHand_Minute"
        case .second:
            imageName = clockHandImageName[.second] ?? "ClockHand_Second"
        }
        return UIImage(named: imageName)
    }
    
    /**
     Sets rotation for clock hand
     */
    func setRotation(to rotation: Double?) {
        guard let rotation = rotation else { return }
        transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
    }
    
    /**
     Sets anchor point for clock hand pivot
     */
    func setAnchor(to newAnchorPoint: CGPoint) {
        
        let currentWidth = bounds.size.width
        let currentHeight = bounds.size.height
        let currentAnchorPoint = layer.anchorPoint
        
        var newPoint = CGPoint(x: currentWidth * newAnchorPoint.x, y: currentHeight * newAnchorPoint.y)
        var oldPoint = CGPoint(x: currentWidth * currentAnchorPoint.x, y: currentHeight * currentAnchorPoint.y)
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = newAnchorPoint

    }
    
    /**
     Sets anchor point for clock hand pivot
     */
    func setClockHandPivot(to newYAnchor: Double = 0.85) {
        var correctedYAnchor = newYAnchor
        if newYAnchor < 0 {
            correctedYAnchor = 0
        }
        if newYAnchor > 1 {
            correctedYAnchor = 1
        }
        setAnchor(to: CGPoint(x: 0.5, y: correctedYAnchor))
    }
    
}
