//
//  CGSize (pointAt).swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 23.08.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CGSize {
    func pointAt(_ commonTransform: CGFloat.Transform = { $0 }) -> CGPoint {
        return CGPoint(x: commonTransform(self.width), y: commonTransform(self.height))
    }
    
    func pointAt(_ widthTransform: CGFloat.Transform = { $0 }, _ heightTransform: CGFloat.Transform = { $0 }) -> CGPoint {
        return CGPoint(x: widthTransform(self.width), y: heightTransform(self.height))
    }
}
