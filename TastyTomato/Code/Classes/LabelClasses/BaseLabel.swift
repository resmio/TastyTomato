//
//  BaseLabel.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
public extension BaseLabel {
    var placeholder: String? {
        get {
            return self._placeholder
        }
        set(newPlaceholder) {
            self._placeholder = newPlaceholder
        }
    }
}


// MARK: Class Declaration
public class BaseLabel: UILabel {
    // Private Constants
    /**This color was retrieved inside an iOS-playground by doing this:
     
     let textField = UITextField()
     textField.placeholder = "Foo"
     let key = "_placeholderLabel"
     let label = textField.value(forKey: key) as! UILabel
     label.textColor
     */
    fileprivate let _placeholderTextColor: UIColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0.098, alpha: 0.22)
    
    // Private Variables
    fileprivate var __placeholder: String?
    
    
    // Variable Overrides
    public override var text: String? {
        get {
            return self._text
        }
        set(newText) {
            self._text = newText
        }
    }
    
//    public override var textColor: UIColor! {
//        get {
//            return self._textColor
//        }
//        set(newTextColor) {
//            self._textColor = newTextColor
//        }
//    }
}


// MARK: // Private
// MARK: Computed Variables
private extension BaseLabel {
    var _text: String? {
        get {
            return super.text
        }
        set(newText) {
            super.text = newText
        }
    }
    
    var _placeholder: String? {
        get {
            return self.__placeholder
        }
        set(newPlaceholderText) {
            
        }
    }
}
