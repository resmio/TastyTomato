//
//  CGRect (Scaled).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CGRect {
    public mutating func scaleByFactor(_ factor: CGFloat) {
        self._scaleByFactor(factor)
    }
    
    public func scaledByFactor(_ factor: CGFloat) -> CGRect {
        return self._scaledByFactor(factor)
    }
}


// MARK: // Private
private extension CGRect {
    mutating func _scaleByFactor(_ factor: CGFloat) {
        self.size.scaleByFactor(factor)
    }
    
    func _scaledByFactor(_ factor: CGFloat) -> CGRect {
        return CGRect(
            origin: self.origin,
            size: self.size.scaledByFactor(factor)
        )
    }
}
