//
//  padTimeUnit.swift
//  AnalogClock
//
//  Created by Justin Reusch on 2/15/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

/**
 Pad time unit for output to two digits (1 to 01, etc.)
 */
func padTimeUnit(_ unPadded: Int) -> String {
    return String(format: "%02d", unPadded)
}



