//
//  BaseButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/27/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BaseButton: UIButton {}


// MARK: // Internal
// MARK: Factory
extension BaseButton {
    class func button_<T: BaseButton>() -> T {
        return self._button()
    }
}


// MARK: // Private
// MARK: Factory
private extension BaseButton {
    private static func _button<T: BaseButton>() -> T {
        let button = T.init(type: .System)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }
}
