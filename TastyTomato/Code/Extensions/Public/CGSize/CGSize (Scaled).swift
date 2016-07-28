//
//  CGSize (Scaled).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension CGSize {
    public func scaledByFactor(factor: CGFloat) -> CGSize {
        return self._scaledByFactor(factor)
    }
    
    public mutating func scaleByFactor(factor: CGFloat) {
        self._scaleByFactor(factor)
    }
}


// MARK: // Private
private extension CGSize {
    private func _scaledByFactor(factor: CGFloat) -> CGSize {
        return CGSize(
            width: self.width * factor,
            height: self.height * factor
        )
    }
    
    private mutating func _scaleByFactor(factor: CGFloat) {
        self.width *= factor
        self.height *= factor
    }
}
