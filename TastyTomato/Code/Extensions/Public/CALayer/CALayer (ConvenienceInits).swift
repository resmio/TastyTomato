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
    public convenience init(withFrame frame: CGRect) {
        self.init()
        self.frame = frame
    }
    
    public convenience init(withSize size: CGSize) {
        self.init(withFrame: size.asCGRect())
    }
}
