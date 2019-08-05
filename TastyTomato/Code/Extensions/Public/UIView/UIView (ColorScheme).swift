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
@objc public extension UIView {
    // Setters
    func setColorAdjustment(_ closure: (() -> Void)?) {
        self._colorAdjustment = closure
    }
    
    // Adjust Colors (Recurses Subviews)
    func adjustColors() {
        self._adjustColors()
    }
}


// MARK: // Private
// MARK: -
private extension ValueAssociationKey {
    static var _colorAdjustment: ValueAssociationKey = ValueAssociationKey()
}


// MARK: -
// MARK: Associated Variables
private extension UIView {
    var _colorAdjustment: (() -> Void)? {
        get { return self.associatedValue(for: &._colorAdjustment) }
        set(newColorAdjustment) {
            self.associate(newColorAdjustment, by: &._colorAdjustment)
            newColorAdjustment?()
        }
    }
}


// MARK: Interface Implementations
private extension UIView {
    func _adjustColors() {
        self.subviews.forEach({ $0.adjustColors() })
        self._colorAdjustment?()
    }
}
