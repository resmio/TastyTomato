//
//  UIView (Centering).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIView {
    var hCenter: CGFloat {
        get {
            return self._hCenter
        }
        set(newHCenter) {
            self._hCenter = newHCenter
        }
    }
    
    var vCenter: CGFloat {
        get {
            return self._vCenter
        }
        set(newVCenter) {
            self._vCenter = newVCenter
        }
    }
    
    func centerInSuperview() {
        self._centerInSuperview()
    }
    
    func centerHInSuperview() {
        self._centerHInSuperview()
    }
    
    func centerVInSuperview() {
        self._centerVInSuperview()
    }
}


// MARK: // Private
private extension UIView {
    var _hCenter: CGFloat {
        get {
            return self.center.x
        }
        set(newHCenter) {
            self.center.x = newHCenter
        }
    }
    
    var _vCenter: CGFloat {
        get {
            return self.center.y
        }
        set(newY) {
            self.center.y = newY
        }
    }
    
    func _centerHInSuperview() {
        if self.superview != nil {
            self.center.x = self.superview!.bounds.width / 2
        } else {
            fatalError("\(self) is not added to a superview and thus cannot be centered horizontally")
        }
    }
    
    func _centerVInSuperview() {
        if self.superview != nil {
            self.center.y = self.superview!.bounds.height / 2
        } else {
            fatalError("\(self) is not added to a superview and thus cannot be centered vertically")
        }
    }
    
    func _centerInSuperview() {
        self.centerHInSuperview()
        self.centerVInSuperview()
    }
}
