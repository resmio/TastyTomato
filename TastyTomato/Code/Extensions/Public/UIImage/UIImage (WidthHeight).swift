//
//  UIImage (WidthAndHeightShorthands).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIImage {
    public var width: CGFloat {
        return self._width
    }
    
    public var height: CGFloat {
        return self._height
    }
}


// MARK: // Private
private extension UIImage {
    private var _width: CGFloat {
        return self.size.width
    }
    
    private var _height: CGFloat {
        return self.size.height
    }
}
