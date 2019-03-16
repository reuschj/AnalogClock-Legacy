//
//  ReusableView.swift
//  AnalogClock
//
//  Created by Justin Reusch on 3/7/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import UIKit

/**
 Defines a named view with XIB file that can be reused throughout the UI
 */
protocol ReusableView {
    
    // Required properties
    var nibName: String? { get set }
    var contentView: UIView? { get set }
    
    // Sets content view
    func loadView() -> Void
    
    // Override these super methods
    func prepareForInterfaceBuilder() -> Void
    
}
