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
    // Setters
    func setPlaceholder(_ placeholder: String?) {
        self._setPlaceholder(placeholder)
    }
    
    func setPlaceholderColor(_ color: UIColor?) {
        self._setPlaceholderColor(color)
    }
    
    func setIsUnderlined(_ underlined: Bool) {
        self._setIsUnderlined(underlined)
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
    **/
    static var defaultPlaceholderColor: UIColor = UIColor(red: 0, green: 0, blue: 0.098, alpha: 0.22)
    
    // Private Variables
    private var _text: String?
    private var _placeholder: String?
    private var _textColor: UIColor = .black
    private var _placeholderColor: UIColor?
    private var _isUnderlined: Bool = false
    
    // Variable Overrides
    public override var text: String? {
        get { return self._text }
        set { self._setText(newValue) }
    }
    
    public override var textColor: UIColor! {
        get { return self._textColor }
        set { self._setTextColor(newValue) }
    }
}


// MARK: // Private
// MARK: Setter Implementations
private extension BaseLabel {
    func _setText(_ text: String?) {
        guard text != self._text else { return }
        self._text = text
        self._updateText()
        self._updateTextColor()
    }

    func _setPlaceholder(_ placeholder: String?) {
        guard placeholder != self._placeholder else { return }
        self._placeholder = placeholder
        self._updateText()
    }
    
    func _setTextColor(_ color: UIColor) {
        guard color != self._textColor else { return }
        self._textColor = color
        self._updateTextColor()
    }
    
    func _setPlaceholderColor(_ color: UIColor?) {
        guard color != self._placeholderColor else { return }
        self._placeholderColor = color ?? BaseLabel.defaultPlaceholderColor
        self._updateTextColor()
    }
    
    func _setIsUnderlined(_ underlined: Bool) {
        guard underlined != self._isUnderlined else { return }
        self._isUnderlined = underlined
        self._updateText()
    }
    
    // Helper
    func _updateText() {
        let text: String? = self._text.isNilOrEmpty ? self._placeholder : self._text
        if self._isUnderlined, let _text: String = text {
            let color: UIColor = self.textColor
            self.attributedText = NSAttributedString(string: _text, attributes: [
                .foregroundColor: color,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: color
            ])
        } else {
            super.text = text
        }
    }
    
    func _updateTextColor() {
        super.textColor = self._text.isNilOrEmpty ? self._placeholderColor : self._textColor
    }
}
