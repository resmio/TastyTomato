//
//  UIView (SizeWidthHeight).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIView {
    public var size: CGSize {
        get {
            return self._size
        }
        set(newSize) {
            self._size = newSize
        }
    }
    
    public var width: CGFloat {
        get {
            return self._width
        }
        set(newWidth) {
            return self._width = newWidth
        }
    }
    
    public var height: CGFloat {
        get {
            return self._height
        }
        set(newHeight) {
            return self._height = newHeight
        }
    }
}


// MARK: // Private
private extension UIView {
    private var _size: CGSize {
        get {
            return self.frame.size
        }
        set(newSize) {
            self.frame.size = newSize
        }
    }
    
    private var _width: CGFloat {
        get {
            return self.frame.width
        }
        set(newWidth) {
            return self.frame.size.width = newWidth
        }
    }
    
    private var _height: CGFloat {
        get {
            return self.frame.height
        }
        set(newHeight) {
            return self.frame.size.height = newHeight
        }
    }
}
