//
//  CGRect (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension CGRect {
    public init(origin: CGPoint) {
        self.init(origin: origin, size: CGSizeZero)
    }
    
    public init(size: CGSize) {
        self.init(origin: CGPointZero, size: size)
    }
}
