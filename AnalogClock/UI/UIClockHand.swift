//
//  UIClockHand.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/6/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

class UIClockHand: UIImageView {
    
    var controller: ClockHandController? = nil
    var type: ClockHandType? {
        return controller?.type
    }
    var time: CurrentTimeAndDate? {
        return controller?.time
    }
    
    convenience init(image: UIImage?, controller: ClockHandController?) {
        self.init(image: image)
        self.controller = controller
    }
    
    func setRotation(to rotation: Double?) {
        guard let rotation = rotation else { return }
        transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
    }
    
    func setAnchor(to newAnchorPoint: CGPoint) {
        
        // TODO: Refind this...
        
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
    
    // TODO: setPosition method
    
    // TODO: setSize method
    
}
