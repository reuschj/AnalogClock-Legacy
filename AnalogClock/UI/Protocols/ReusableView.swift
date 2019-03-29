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
protocol ReusableView: UIView {
    
    // Required properties
    var nibName: String? { get set }
    var contentView: UIView? { get set }
    
    // Sets content view
    func loadView() -> Void
    func loadViewFromNib() -> UIView?

    // Override these super methods
    func prepareForInterfaceBuilder() -> Void
    
    
    
}

// Extends for default implementations
extension ReusableView {
    
    // Loads view from XIB file as sub-view
    func loadView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    // Loads the view from a XIB file
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    // Add to prepareForInterfaceBuilder() override to load view
    func prepareViewForInterfaceBuilder() {
        loadView()
        contentView?.prepareForInterfaceBuilder()
    }
}
