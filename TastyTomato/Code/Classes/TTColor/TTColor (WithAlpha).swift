//
//  TTColor (WithAlpha).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/8/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension TTColor {
    public func withAlpha(alpha: CGFloat) -> TTColor {
        return self._withAlpha(alpha)
    }
}


// MARK: // Private
private extension TTColor {
    private func _withAlpha(alpha: CGFloat) -> TTColor {
        return self.colorWithAlphaComponent(alpha) as! TTColor
    }
}
