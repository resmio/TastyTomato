//
//  UIView (Area).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIView {
    public var area: CGFloat {
        return self._area
    }
}


// MARK: // Private
private extension UIView {
    private var _area: CGFloat {
        return self.frame.area
    }
}
