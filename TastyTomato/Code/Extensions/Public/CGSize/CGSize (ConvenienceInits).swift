//
//  CGSize (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension CGSize {
    init(width: CGFloat) {
        self.init(width: width, height: 0)
    }
    
    init(height: CGFloat) {
        self.init(width: 0, height: height)
    }
}
