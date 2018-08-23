//
//  CGSize (Transformed).swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 23.08.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CGSize {
    public func transformed(_ commonTransform: CGFloat.Transform = { $0 }) -> CGSize {
        return CGSize(width: commonTransform(self.width), height: commonTransform(self.height))
    }
    
    public func transformed(_ widthTransform: CGFloat.Transform = { $0 }, _ heightTransform: CGFloat.Transform = { $0 }) -> CGSize {
        return CGSize(width: widthTransform(self.width), height: heightTransform(self.height))
    }
}
