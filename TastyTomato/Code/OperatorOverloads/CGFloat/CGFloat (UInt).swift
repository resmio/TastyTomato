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
public func ==(l: CGFloat, r: UInt) -> Bool {
    return (l == CGFloat(r))
}

public func ==(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) == r)
}


public func !=(l: CGFloat, r: UInt) -> Bool {
    return (l != CGFloat(r))
}

public func !=(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) != r)
}


public func <(l: CGFloat, r: UInt) -> Bool {
    return (l < CGFloat(r))
}

public func <(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) < r)
}


public func >(l: CGFloat, r: UInt) -> Bool {
    return (l > CGFloat(r))
}

public func >(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) > r)
}


public func <=(l: CGFloat, r: UInt) -> Bool {
    return (l <= CGFloat(r))
}

public func <=(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) <= r)
}


public func >=(l: CGFloat, r: UInt) -> Bool {
    return (l >= CGFloat(r))
}

public func >=(l: UInt, r: CGFloat) -> Bool {
    return (CGFloat(l) >= r)
}


// MARK: Addition
public func +(l: CGFloat, r: UInt) -> CGFloat {
    return (l + CGFloat(r))
}

public func +(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) + r)
}


// MARK: Subtraction
public func -(l: CGFloat, r: UInt) -> CGFloat {
    return (l - CGFloat(r))
}

public func -(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) - r)
}


// MARK: Multiplication
public func *(l: CGFloat, r: UInt) -> CGFloat {
    return (l * CGFloat(r))
}

public func *(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) * r)
}


// MARK: Division
public func /(l: CGFloat, r: UInt) -> CGFloat {
    return (l / CGFloat(r))
}

public func /(l: UInt, r: CGFloat) -> CGFloat {
    return (CGFloat(l) / r)
}
