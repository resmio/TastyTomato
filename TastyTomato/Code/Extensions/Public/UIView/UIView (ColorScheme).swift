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
public extension UIView {
    var adjustColors: (() -> Void)? {
        get { return self._adjustColors }
        set { self._adjustColors = newValue }
    }
}


// MARK: // Private
// MARK: -
private extension ValueAssociationKey {
    static var _adjustColors: ValueAssociationKey = ValueAssociationKey()
}


// MARK: -
private extension UIView {
    var _adjustColors: (() -> Void)? {
        get { return self.associatedValue(for: &._adjustColors) }
        set(newAdjustColors) {
            self.associate(newAdjustColors, by: &._adjustColors)
            newAdjustColors?()
        }
    }
}
