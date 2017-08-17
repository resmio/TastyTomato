//
//  BaseLabel.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit
import SignificantSpices


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
    
    var placeholderTextColor: UIColor? {
        get {
            return self._placeholderTextColor
        }
        set(newPlaceholderTextColor) {
            self._placeholderTextColor = newPlaceholderTextColor
        }
    }
}


// MARK: Class Declaration
public class BaseLabel: UILabel {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    // Override Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._setup()
    }
    
    // Private Setup Implementation
    private func _setup() {
        if self._isShowingPlaceholder {
            super.text = self.placeholder
            super.textColor = self.placeholderTextColor
        }
    }
    
    // Private Constants
    /**This color was retrieved inside an iOS-playground by doing this:
     
     let textField = UITextField()
     textField.placeholder = "Foo"
     let key = "_placeholderLabel"
     let label = textField.value(forKey: key) as! UILabel
     label.textColor
     */
    fileprivate let _defaultPlaceholderTextColor: UIColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0.098, alpha: 0.22)
    
    // Private Lazy Variables
    fileprivate lazy var __placeholderTextColor: UIColor = self._defaultPlaceholderTextColor
    
    // Private Variables
    fileprivate var __placeholder: String?
    fileprivate var __textColorBackup: UIColor = .black
    fileprivate var _isShowingPlaceholder: Bool = true
    
    
    // Variable Overrides
    public override var text: String? {
        get {
            return self._text
        }
        set(newText) {
            self._text = newText
        }
    }
    
    public override var textColor: UIColor! {
        get {
            return self._textColor
        }
        set(newTextColor) {
            self._textColor = newTextColor
        }
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension BaseLabel {
    var _placeholder: String? {
        get {
            return self.__placeholder
        }
        set(newPlaceholder) {
            guard newPlaceholder != self.__placeholder else { return }
            self.__placeholder = newPlaceholder
            if self._isShowingPlaceholder {
                super.text = newPlaceholder
            }
        }
    }
    
    var _placeholderTextColor: UIColor? {
        get {
            return self.__placeholderTextColor
        }
        set(newPlaceholderTextColor) {
            guard newPlaceholderTextColor != self.__placeholderTextColor else { return }
            let newColor: UIColor = newPlaceholderTextColor ?? self._defaultPlaceholderTextColor
            self.__placeholderTextColor = newColor
            if self._isShowingPlaceholder {
                super.textColor = newColor
            }
        }
    }
    
    var _text: String? {
        get {
            return self._isShowingPlaceholder ? "" : super.text
        }
        set(newText) {
            guard newText != self._text else { return }
            if newText.isNilOrEmpty {
                self._isShowingPlaceholder = true
                super.text = self.placeholder
                self.__textColorBackup = super.textColor
                super.textColor = self.placeholderTextColor
            } else {
                self._isShowingPlaceholder = false
                super.text = newText
                super.textColor = self.__textColorBackup
            }
        }
    }
    
    var _textColor: UIColor! {
        get {
            return self._isShowingPlaceholder ? self.__textColorBackup : super.textColor
        }
        set(newTextColor) {
            if self._isShowingPlaceholder {
                self.__textColorBackup = newTextColor
            } else {
                super.textColor = newTextColor
            }
        }
    }
}
