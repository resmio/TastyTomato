//
//  BaseTextField.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/26/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BaseTextField: UITextField {}


// MARK: // Internal
// MARK: Factory
extension BaseTextField {
    class func textField_<T: BaseTextField>() -> T {
        return self._textField()
    }
}


// MARK: // Private
// MARK: Factory
private extension BaseTextField {
    private static func _textField<T: BaseTextField>() -> T {
        let button = T.init()
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.GrayCCCCCC().CGColor
        button.clipsToBounds = true
        return button
    }
}

