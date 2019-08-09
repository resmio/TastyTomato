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
        self._colorAdjusters.forEach({ $1.adjust($0) })
    }
    
    // Adjust Colors Of This View
    func adjustColors() {
        UIView._colorAdjusters[self]?.adjust(self)
    }
    
    // Setters
    func setColorAdjustment(_ colorAdjustment: @escaping (UIView) -> Void) {
        UIView._colorAdjusters[self] = ColorAdjuster(colorAdjustment)
    }
}


// MARK: // Private
// MARK: Color Adjusters
private extension UIView {
    static var _colorAdjusters: WeakKeyDict<UIView, ColorAdjuster> = [:]
}
