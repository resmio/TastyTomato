//
//  UIView (SizeWidthHeight).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
extension UIView {
    @objc open var size: CGSize {
        get {
            return self._size
        }
        set(newSize) {
            self._size = newSize
        }
    }
    
    @objc open var width: CGFloat {
        get {
            return self._width
        }
        set(newWidth) {
            self._width = newWidth
        }
    }
    
    @objc open var height: CGFloat {
        get {
            return self._height
        }
        set(newHeight) {
            self._height = newHeight
        }
    }
}


// MARK: // Private
private extension UIView {
    var _size: CGSize {
        get {
            return self.frame.size
        }
        set(newSize) {
            self.frame.size = newSize
        }
    }
    
    var _width: CGFloat {
        get {
            return self.frame.width
        }
        set(newWidth) {
            self.frame.size.width = newWidth
        }
    }
    
    var _height: CGFloat {
        get {
            return self.frame.height
        }
        set(newHeight) {
            self.frame.size.height = newHeight
        }
    }
}
