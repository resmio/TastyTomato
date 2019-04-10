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
    init(origin: CGPoint) {
        self.init(origin: origin, size: CGSize.zero)
    }
    
    init(size: CGSize) {
        self.init(origin: CGPoint.zero, size: size)
    }
}
