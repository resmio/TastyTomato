//
//  UIColor (WithAlpha).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/8/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIColor {
    public func withAlpha(alpha: CGFloat) -> UIColor {
        return self._withAlpha(alpha)
    }
}


// MARK: // Private
private extension UIColor {
    private func _withAlpha(alpha: CGFloat) -> UIColor {
        return self.colorWithAlphaComponent(alpha)
    }
}
