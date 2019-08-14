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
    // Setters
    func setPlaceholder(_ placeholder: String?) {
        self._setPlaceholder(placeholder)
    }
    
    func setPlaceholderTextColor(_ color: UIColor?) {
        self._setPlaceholderTextColor(color)
    }
}


// MARK: Class Declaration
public class BaseLabel: UILabel {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    // Private Setup Implementation
    private func _init() {
        self.setColorAdjustment({ ($0 as? BaseLabel)?.textColor = ColorScheme.text.default })
        if self._isShowingPlaceholder {
            super.text = self._placeholder
            super.textColor = self._placeholderTextColor
        }
    }
    
    // Private Constants
    /**This color was retrieved inside an iOS-playground by doing this:
     
     let textField = UITextField()
     textField.placeholder = "Foo"
     let key = "_placeholderLabel"
     let label = textField.value(forKey: key) as! UILabel
     label.textColor
    **/
    private let _defaultPlaceholderTextColor: UIColor = UIColor(red: 0, green: 0, blue: 0.098, alpha: 0.22)
    
    // Private Lazy Variables
    private lazy var _placeholderTextColor: UIColor = self._defaultPlaceholderTextColor
    
    // Private Variables
    private var _placeholder: String?
    private var _textColorBackup: UIColor = .black
    private var _isShowingPlaceholder: Bool = true
    
    // Variable Overrides
    public override var text: String? {
        get { return self._isShowingPlaceholder ? "" : super.text }
        set { self._setText(newValue) }
    }
    
    public override var textColor: UIColor! {
        get { return self._isShowingPlaceholder ? self._textColorBackup : super.textColor }
        set { self._setTextColor(newValue) }
    }
}


// MARK: // Private
// MARK: Override Implementations
private extension BaseLabel {
    func _setText(_ text: String?) {
        let currentText: String? = self._isShowingPlaceholder ? "" : super.text
        guard text != currentText else { return }
        if text.isNilOrEmpty {
            self._isShowingPlaceholder = true
            super.text = self._placeholder
            self._textColorBackup = super.textColor
            super.textColor = self._placeholderTextColor
        } else {
            self._isShowingPlaceholder = false
            super.text = text
            super.textColor = self._textColorBackup
        }
    }
    
    func _setTextColor(_ color: UIColor) {
        if self._isShowingPlaceholder {
            self._textColorBackup = color
        } else {
            super.textColor = color
        }
    }
}


// MARK: Setter Implementations
private extension BaseLabel {
    func _setPlaceholder(_ placeholder: String?) {
        guard placeholder != self._placeholder else { return }
        self._placeholder = placeholder
        if self._isShowingPlaceholder {
            super.text = placeholder
        }
    }
    
    func _setPlaceholderTextColor(_ color: UIColor?) {
        guard color != self._placeholderTextColor else { return }
        let newColor: UIColor = color ?? self._defaultPlaceholderTextColor
        self._placeholderTextColor = newColor
        if self._isShowingPlaceholder {
            super.textColor = newColor
        }
    }
}
