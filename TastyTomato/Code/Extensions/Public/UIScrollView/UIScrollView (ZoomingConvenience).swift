//
//  UIScrollView (ZoomingConvenience).swift
//  TastyTomato
//
//  Created by Jan Nash on 11/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
extension UIScrollView {
    public func zoomOut(animated: Bool = true) {
        self._zoomOut(animated: animated)
    }
    
    public func zoomIn(animated: Bool = true) {
        self._zoomIn(animated: animated)
    }
    
    public func zoom(to zoomScale: CGFloat, animated: Bool = true) {
        self._zoom(to: zoomScale, animated: animated)
    }
    
}


// MARK: // Internal
internal extension UIScrollView {
    func zoomOut_(animated: Bool = true) -> Bool {
        return self._zoomOut(animated: animated)
    }
    
    func zoomIn_(animated: Bool = true) -> Bool {
        return self._zoomIn(animated: animated)
    }
    
    func zoom_(to zoomScale: CGFloat, animated: Bool = true) -> Bool {
        return self._zoom(to: zoomScale, animated: animated)
    }
}


// MARK: // Private
private extension UIScrollView {
    @discardableResult func _zoomOut(animated: Bool) -> Bool {
        if self.zoomScale != self.minimumZoomScale {
            self.setZoomScale(self.minimumZoomScale, animated: animated)
            return true
        } else {
            return false
        }
    }
    
    @discardableResult func _zoomIn(animated: Bool) -> Bool {
        if self.zoomScale != self.maximumZoomScale {
            self.setZoomScale(self.maximumZoomScale, animated: animated)
            return true
        } else {
            return false
        }
    }
    
    @discardableResult func _zoom(to zoomScale: CGFloat, animated: Bool) -> Bool {
        if self.zoomScale == zoomScale {
            self.setZoomScale(zoomScale, animated: animated)
            return true
        } else {
            return false
        }
    }
}
