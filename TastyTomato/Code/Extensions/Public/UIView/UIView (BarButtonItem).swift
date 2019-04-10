//
//  UIView (BarButtonItem).swift
//  TastyTomato
//
//  Created by Jan Nash on 9/1/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Factory
public extension UIView {
    func asBarButtonItem() -> UIBarButtonItem {
        return self._asBarButtonItem()
    }
}


// MARK: // Private
// MARK: Factory Implementation
private extension UIView {
    func _asBarButtonItem() -> UIBarButtonItem {
        let barButtonItem: UIBarButtonItem = UIBarButtonItem()
        barButtonItem.customView = self
        return barButtonItem
    }
}
