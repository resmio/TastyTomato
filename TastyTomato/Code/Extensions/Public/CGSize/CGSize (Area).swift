//
//  CGSize (Area).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension CGSize {
    var area: CGFloat {
        return self._area
    }
}


// MARK: // Private
private extension CGSize {
    var _area: CGFloat {
        return self.width * self.height
    }
}
