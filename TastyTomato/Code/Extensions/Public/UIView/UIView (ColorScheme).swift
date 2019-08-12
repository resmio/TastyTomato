//
//  UIView (ColorScheme).swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 05.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit
import SignificantSpices


// MARK: // Public
// MARK: Interface
public extension UIView {
    // Adjust Colors Of All Registered Views
    static func adjustColorsOfAllRegisteredViews() {
        UIView.animate(withDuration: 0.2) { self._colorAdjusters.forEach({ $1.adjust($0) }) }
    }
    
    // Adjust Colors Of This View
    func adjustColors() {
        UIView._colorAdjusters[self]?.adjust(self)
    }
    
    // Setters
    func setColorAdjustment(_ colorAdjustment: ((UIView) -> Void)?) {
        self._setColorAdjustment(colorAdjustment)
    }
}


// MARK: // Private
// MARK: Implementation
private extension UIView {
    static var _colorAdjusters: WeakKeyDict<UIView, ColorAdjuster> = [:]

    func _setColorAdjustment(_ colorAdjustment: ((UIView) -> Void)?) {
        if let adjustment: (UIView) -> Void = colorAdjustment {
            UIView._colorAdjusters[self] = ColorAdjuster(adjustment)
            colorAdjustment(self)
        } else {
            UIView._colorAdjusters[self] = nil
        }
    }
}
