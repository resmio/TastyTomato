//
//  UIView (ScaleByFactor).swift
//  TastyTomato
//
//  Created by Jan Nash on 10/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIView {
    func scale(byFactor factor: CGFloat) {
        self._scale(byFactor: factor)
    }
}


// MARK: // Private
private extension UIView {
    func _scale(byFactor factor: CGFloat) {
        if factor == 0 || factor == 1 {
        return
        }
        
        self.size.scaleByFactor(factor)
    }
}
