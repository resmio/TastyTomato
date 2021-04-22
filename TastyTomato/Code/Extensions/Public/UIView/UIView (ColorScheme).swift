//
//  UIView (ColorScheme).swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 05.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit
import ObjectiveC
import SignificantSpices


// MARK: // Public
// MARK: Interface
public extension UIView {
    // Adjust Colors Of All Registered Views
    static func adjustColorsOfAllRegisteredViews() {
        let adjustments = UIView._colorAdjustments.values
        UIView.animate(withDuration: 0.2) { adjustments.forEach({ $0() }) }
    }
    
    // Adjust Colors Of This View
    func adjustColors() {
        let id: ObjectIdentifier = ObjectIdentifier(self)
        let adjustment: (() -> Void)? = UIView._colorAdjustments[id]
        adjustment?()
    }
    
    // Setters
    func setColorAdjustment(_ colorAdjustment: ((UIView) -> Void)?) {
        self._setColorAdjustment(colorAdjustment)
    }
}


// MARK: // Private
// MARK: Implementation
private extension UIView {
    class DeinitCallback {
        init(_ callback: @escaping () -> Void) { self._callback = callback }
        private let _callback: () -> Void
        deinit { _callback() }
    }
    
    static var _colorAdjustments: [ObjectIdentifier: () -> Void] = [:]

    func _setColorAdjustment(_ colorAdjustment: ((UIView) -> Void)?) {
        let id: ObjectIdentifier = ObjectIdentifier(self)
        
        var associationKey: Void?
        objc_setAssociatedObject(
            self, &associationKey,
            DeinitCallback({ UIView._colorAdjustments[id] = nil }),
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
        
        if let adjustment: (UIView) -> Void = colorAdjustment {
            UIView._colorAdjustments[id] = { [weak self] in
                guard let self = self else { return }
                adjustment(self)
            }
            adjustment(self)
        } else {
            UIView._colorAdjustments[id] = nil
        }
    }
}
