//
//  CGSize (CGRect).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CGSize {
    public func asCGRect() -> CGRect {
        return self._asCGRect()
    }
}


// MARK: // Private
private extension CGSize {
    private func _asCGRect() -> CGRect {
        return CGRect(size: self)
    }
}
