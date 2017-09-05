//
//  UIImage (WidthAndHeightShorthands).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
@objc public extension UIImage {
    public var width: CGFloat {
        return self._width
    }
    
    public var height: CGFloat {
        return self._height
    }
}


// MARK: // Private
private extension UIImage {
    var _width: CGFloat {
        return self.size.width
    }
    
    var _height: CGFloat {
        return self.size.height
    }
}
