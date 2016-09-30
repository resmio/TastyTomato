//
//  CGRect (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CGRect {
    public init(origin: CGPoint) {
        self.init(origin: origin, size: CGSize.zero)
    }
    
    public init(size: CGSize) {
        self.init(origin: CGPoint.zero, size: size)
    }
}
