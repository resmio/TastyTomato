//
//  UIDatePicker (TextColor).swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 12.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIDatePicker {
    // FIXME: This is an ugly hack. Unfortunately, it seems like there's no proper way to achieve this.
    var textColor: UIColor? {
        get { return self.value(forKey: _Key.textColor) as? UIColor }
        set { self.setValue(newValue, forKey: _Key.textColor) }
    }
}


// MARK: // Private
private extension UIDatePicker {
    enum _Key {
        static let textColor: String = "textColor"
    }
}
