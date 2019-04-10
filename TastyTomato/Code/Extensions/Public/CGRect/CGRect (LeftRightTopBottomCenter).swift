//
//  CGRect (LeftRightTopBottomCenter).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CGRect {
    var left: CGFloat {
        get {
            return self._left
        }
        set(newLeft) {
            self._left = newLeft
        }
    }
    
    var right: CGFloat {
        get {
            return self._right
        }
        set(newRight) {
            self._right = newRight
        }
    }
    
    var top: CGFloat {
        get {
            return self._top
        }
        set(newTop) {
            self._top = newTop
        }
    }
    
    var bottom: CGFloat {
        get {
            return self._bottom
        }
        set(newBottom) {
            self._bottom = newBottom
        }
    }
    
    var center: CGPoint {
        get {
            return self._center
        }
        set(newCenter) {
            self._center = newCenter
        }
    }
}


// MARK: // Private 
private extension CGRect {
    var _left: CGFloat {
        get {
            return self.origin.x
        }
        set(newLeft) {
            self.origin.x = newLeft
        }
    }
    
    var _right: CGFloat {
        get {
            return self.left + self.width
        }
        set(newRight) {
            self.origin.x += newRight - self.right
        }
    }
    
    var _top: CGFloat {
        get {
            return self.origin.y
        }
        set(newTop) {
            self.origin.y = newTop
        }
    }
    
    var _bottom: CGFloat {
        get {
            return self.origin.y + self.height
        }
        set(newBottom) {
            self.origin.y += newBottom - self.bottom
        }
    }
    
    var _center: CGPoint {
        get {
            let x: CGFloat = self.midX
            let y: CGFloat = self.midY
            return CGPoint(x: x, y: y)
        }
        set(newCenter) {
            self.left += newCenter.x - self.center.x
            self.top += newCenter.y - self.center.y
        }
    }
}
