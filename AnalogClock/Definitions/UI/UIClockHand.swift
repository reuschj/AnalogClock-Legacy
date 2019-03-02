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
class UIClockHand: UIImageView, Updatable {
    
    // This controller holds the time and type and calculates the rotation
    var controller: ClockHandController
    
    // Gets clock hand type from controller
    var type: ClockHandType {
        return controller.type
    }
    
    // Gets time from controller
    var time: CurrentTimeAndDate {
        return controller.time
    }
    
    // Initializer
    // Use this when you want to explicitly pass the image name
    init(withImage imageName: String, controlledBy controller: ClockHandController, withPivot pivot: Double = defaultClockPivot) {
        self.controller = controller
        let image = UIImage(named: imageName)
        super.init(image: image)
        setClockHandPivot(to: pivot)
    }
    
    // Initializer
    // Use this when you want the image auto-set by lookup
    init(controlledBy controller: ClockHandController, withPivot pivot: Double = defaultClockPivot) {
        self.controller = controller
        let image = UIClockHand.getClockHandImage(withType: controller.type)
        super.init(image: image)
        setClockHandPivot(to: pivot)
    }
    
    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        self.controller = ClockHandController(asType: .hour, withTime: CurrentTimeAndDate())
        super.init(coder: aDecoder)
        setClockHandPivot(to: defaultClockPivot)
    }
    
    // Actions to take when an update is called for (driven by external timer which will call for periodic updates)
    func update() {
        setRotation(to: controller.rotationRadians)
    }
    
    // Sets rotation for clock hand
    func setRotation(to rotation: Double?) {
        guard let rotation = rotation else { return }
        transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
        print(transform)
    }
    
    // Sets anchor point for clock hand pivot
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
    
    // Sets anchor point for clock hand pivot
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
    
    // Looks up the clock hand image for given type and creates a UIImage instance
    static func getClockHandImage(withType type: ClockHandType) -> UIImage? {
        guard let imageName = clockHandImageName[type] else { return nil }
        return UIImage(named: imageName)
    }
    
}
