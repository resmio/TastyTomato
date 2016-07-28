//
//  CGFloat (UInt).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Equation
func ==(l: CGFloat, r: UInt) -> Bool {
    return (l == CGFloat(r))
}

func ==(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) == r)
}


func !=(l: CGFloat, r: UInt) -> Bool {
    return (l != CGFloat(r))
}

func !=(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) != r)
}


func <(l: CGFloat, r: UInt) -> Bool {
    return (l < CGFloat(r))
}

func <(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) < r)
}


func >(l: CGFloat, r: UInt) -> Bool {
    return (l > CGFloat(r))
}

func >(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) > r)
}


func <=(l: CGFloat, r: UInt) -> Bool {
    return (l <= CGFloat(r))
}

func <=(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) <= r)
}


func >=(l: CGFloat, r: UInt) -> Bool {
    return (l >= CGFloat(r))
}

func >=(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) >= r)
}


// MARK: Addition
func +(l: CGFloat, r: UInt) -> CGFloat {
    return (l + CGFloat(r))
}

func +(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) + r)
}


// MARK: Subtraction
func -(l: CGFloat, r: UInt) -> CGFloat {
    return (l - CGFloat(r))
}

func -(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) - r)
}


// MARK: Multiplication
func *(l: CGFloat, r: UInt) -> CGFloat {
    return (l * CGFloat(r))
}

func *(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) * r)
}


// MARK: Division
func /(l: CGFloat, r: UInt) -> CGFloat {
    return (l / CGFloat(r))
}

func /(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) / r)
}
