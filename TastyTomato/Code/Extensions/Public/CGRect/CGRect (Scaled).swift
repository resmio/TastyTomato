//
//  CGRect (Scaled).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension CGRect {
    public mutating func scaleByFactor(factor: CGFloat) {
        self._scaleByFactor(factor)
    }
    
    public func scaledByFactor(factor: CGFloat) -> CGRect {
        return self._scaledByFactor(factor)
    }
}


// MARK: // Private
private extension CGRect {
    private mutating func _scaleByFactor(factor: CGFloat) {
        self.size.scaleByFactor(factor)
    }
    
    private func _scaledByFactor(factor: CGFloat) -> CGRect {
        return CGRect(
            origin: self.origin,
            size: self.size.scaledByFactor(factor)
        )
    }
}
