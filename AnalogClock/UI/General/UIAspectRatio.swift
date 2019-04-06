//
//  UIAspectRatio.swift
//  AnalogClock
//
//  Created by Justin Reusch on 4/5/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

// Holds an aspect ratio to use for UI elements
struct UIAspectRatio: CustomStringConvertible {
    
    var ratio: (width: CGFloat, height: CGFloat)
    
    var description: String {
        return "\(ratio.width) : \(ratio.height) (width : height)"
    }
    
    var widthToHeight: CGFloat {
        return ratio.width / ratio.height
    }
    
    var heightToWidth: CGFloat {
        return ratio.height / ratio.width
    }
    
    // Initializers
    
    init(width: CGFloat, height: CGFloat) {
        ratio = (width, height)
    }
    
    init(width: Double, height: Double) {
        ratio = (CGFloat(width), CGFloat(height))
    }
    
    init(width: Int, height: Int) {
        ratio = (CGFloat(width), CGFloat(height))
    }
    
    // Get a width from known height
    
    func getWidth(fromHeight height: CGFloat) -> CGFloat {
        return widthToHeight * ratio.height
    }
    
    func getWidth(fromHeight height: Double) -> CGFloat {
        return widthToHeight * CGFloat(height)
    }
    
    func getWidth(fromHeight height: Int) -> CGFloat {
        return widthToHeight * CGFloat(height)
    }
    
    // Get a width from known height
    
    func getHeight(fromWidth width: CGFloat) -> CGFloat {
        return heightToWidth * width
    }
    
    func getHeight(fromWidth width: Double) -> CGFloat {
        return heightToWidth * CGFloat(width)
    }
    
    func getHeight(fromWidth width: Int) -> CGFloat {
        return heightToWidth * CGFloat(width)
    }
}
