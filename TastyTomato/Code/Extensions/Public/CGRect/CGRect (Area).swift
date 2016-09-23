//
//  CGRect (Area).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension CGRect {
    public var area: CGFloat {
        return self._area
    }
}


// MARK: // Private
private extension CGRect {
    private var _area: CGFloat {
        return self.size.area
    }
}
