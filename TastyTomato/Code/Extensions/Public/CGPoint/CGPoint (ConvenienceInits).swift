//
//  CGPoint (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension CGPoint {
    init(x: CGFloat) {
        self.init(x: x, y: 0)
    }
    
    init(y: CGFloat) {
        self.init(x: 0, y: y)
    }
}
