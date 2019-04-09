//
//  CALayer (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CALayer {
    @objc convenience init(frame: CGRect) {
        self.init()
        self.frame = frame
    }
    
    @objc convenience init(size: CGSize) {
        self.init(frame: size.asCGRect())
    }
}
