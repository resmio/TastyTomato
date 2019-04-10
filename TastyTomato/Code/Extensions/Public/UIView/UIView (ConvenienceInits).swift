//
//  UIView (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIView {
    convenience init(origin: CGPoint) {
        self.init(frame: CGRect(origin: origin))
    }
    
    @objc convenience init(size: CGSize) {
        self.init(frame: CGRect(size: size))
    }
}
