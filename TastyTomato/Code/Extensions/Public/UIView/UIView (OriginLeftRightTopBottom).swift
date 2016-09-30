//
//  UIView (LeftRightTopBottom).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIView {
    public var origin: CGPoint {
        get {
            return self._origin
        }
        set(newOrigin) {
            self._origin = newOrigin
        }
    }
    
    public var left: CGFloat {
        get {
            return self._left
        }
        set(newLeft) {
            self._left = newLeft
        }
    }
    
    public var right: CGFloat {
        get {
            return self._right
        }
        set(newRight) {
            self._right = newRight
        }
    }
    
    public var top: CGFloat {
        get {
            return self._top
        }
        set(newTop) {
            self._top = newTop
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self._bottom
        }
        set(newBottom) {
            self._bottom = newBottom
        }
    }
}


// MARK: // Private
private extension UIView {
    var _origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(newOrigin) {
            self.frame.origin = newOrigin
        }
    }
    
    var _left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            self.frame.origin.x = newLeft
        }
    }
    
    var _right: CGFloat {
        get {
            return self.left + self.width
        }
        set(newRight) {
            self.frame.origin.x += newRight - self.right
        }
    }
    
    var _top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newTop) {
            self.frame.origin.y = newTop
        }
    }
    
    var _bottom: CGFloat {
        get {
            return self.frame.origin.y + self.height
        }
        set(newBottom) {
            self.frame.origin.y += newBottom - self.bottom
        }
    }
}
