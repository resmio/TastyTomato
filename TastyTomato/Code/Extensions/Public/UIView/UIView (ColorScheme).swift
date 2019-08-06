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
    // Setters
    func setColorAdjustment<T: UIView>(_ closure: ((T) -> Void)?) {
        self._setColorAdjustment(closure)
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
    func _adjustColors<T: UIView>(of view: T) {
        guard let closure: ((T) -> Void) = self.associatedValue(for: &._colorAdjustment) else { return }
        closure(view)
    }
    
    func _setColorAdjustment<T: UIView>(_ closure: ((T) -> Void)?) {
        guard let slf: T = self as? T else { return }
        self.associate(closure, by: &._colorAdjustment)
        closure?(slf)
    }
}


// MARK: Interface Implementations
private extension UIView {
    func _adjustColors() {
        self.subviews.forEach({ $0.adjustColors() })
        self._adjustColors(of: self)
    }
}
