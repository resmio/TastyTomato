//
//  CAShapeLayer (ConvenienceInits).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CAShapeLayer {
    @objc public convenience init(path p: UIBezierPath) {
        self.init()
        self.path = p.cgPath
    }
    
    @objc public convenience init(rect r: CGRect) {
        self.init(path: UIBezierPath(rect: r))
    }
}
