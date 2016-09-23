//
//  UIButton (SetTitle).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIButton {
    public func setTitle(title: String) {
        self._setTitle(title)
    }
}


// MARK: // Private
private extension UIButton {
    private func _setTitle(title: String) {
        self.setTitle(title, forState: .Normal)
    }
}
