//
//  Ratio.swift
//  AnalogClock
//
//  Created by Justin Reusch on 4/5/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

// TODO: Make generic

// Find the greatest common devisor of integers
func findGCD(of a: Int, and b: Int) -> Int {
    let remainder = abs(a) % abs(b)
    if remainder != 0 {
        return findGCD(of: abs(b), and: remainder)
    } else {
        return abs(b)
    }
}

// Find the greatest common devisor of doubles
func findGCD(of a: Double, and b: Double) -> Double {
    let remainder = abs(a).truncatingRemainder(dividingBy: abs(b))
    if remainder != 0 {
        return findGCD(of: abs(b), and: remainder)
    } else {
        return abs(b)
    }
}

// Reduces the ratio of two integers
func reduceRatio(of a: Int, and b: Int) -> (a: Int, b: Int) {
    let gcd: Int = findGCD(of: a, and: b)
    return (a / gcd, b / gcd)
}

// Reduces the ratio of two doubles
func reduceRatio(of a: Double, and b: Double) -> (a: Double, b: Double) {
    let gcd: Double = findGCD(of: a, and: b)
    return (a / gcd, b / gcd)
}
