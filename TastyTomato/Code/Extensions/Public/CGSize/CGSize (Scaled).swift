//
//  CGSize (Scaled).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CGSize {
    func scaledByFactor(_ factor: CGFloat) -> CGSize {
        return self._scaledByFactor(factor)
    }
    
    mutating func scaleByFactor(_ factor: CGFloat) {
        self._scaleByFactor(factor)
    }
}


// MARK: // Private
private extension CGSize {
    func _scaledByFactor(_ factor: CGFloat) -> CGSize {
        return CGSize(
            width: self.width * factor,
            height: self.height * factor
        )
    }
    
    mutating func _scaleByFactor(_ factor: CGFloat) {
        self.width *= factor
        self.height *= factor
    }
}
