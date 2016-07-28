//
//  UIView (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIView {
    public convenience init(origin: CGPoint) {
        self.init(frame: CGRect(origin: origin))
    }
    
    public convenience init(size: CGSize) {
        self.init(frame: CGRect(size: size))
    }
}
