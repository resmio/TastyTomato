//
//  TextButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Interface
public extension TextButton {
    public var underlined: Bool {
        get {
            return self._underlined
        }
        set(newUnderlined) {
            self._underlined = newUnderlined
        }
    }
}


// MARK: Class Declaration
public class TextButton: BaseButton {
    // Private Variables
    private var _underlined: Bool = false {
        didSet { self._updateTitle() }
    }
    
    // Setup Override
    public override func setup() {
        self._setup()
    }
    
    // setTitle Override
    public override func setTitle(_ title: String?, for state: UIControlState) {
        self._setTitle(title, for: state)
    }
    
    // setTitleColor Override
    public override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        self._setTitleColor(color, for: state)
    }
}


// MARK: // Private
// MARK: Setup Override Implementation
private extension TextButton {
    func _setup() {
        super.setup()
        self.xPadding = 0
        self.yPadding = 0
        self.setTitleColor(.black, for: .normal)
    }
}


// MARK: setTitle Override Implementation
private extension TextButton {
    func _setTitle(_ title: String?, for state: UIControlState) {
        if title?.isEmpty ?? true {
            self.setAttributedTitle(nil, for: state)
            return
        }
        
        let titleColor: UIColor = self.titleColor(for: state) ?? .black
        let underlineStyle: NSUnderlineStyle = self.underlined ? .styleSingle : .styleNone
        let attributes: [NSAttributedStringKey : Any] = [
            .foregroundColor: titleColor,
            .underlineStyle: underlineStyle.rawValue
        ]
        
        let attributedTitle: NSAttributedString = NSAttributedString(
            string: title!,
            attributes: attributes
        )
        
        super.setTitle(title, for: state)
        self.setAttributedTitle(attributedTitle, for: state)
    }
}


// MARK: setTitleColor Override Implementation
private extension TextButton {
    func _setTitleColor(_ color: UIColor?, for state: UIControlState) {
        super.setTitleColor(color, for: state)
        self._updateTitle()
    }
}


// MARK: Update Title
private extension TextButton {
    func _updateTitle() {
        let state: UIControlState = self.state
        let title: String? = self.title(for: state)
        self._setTitle(title, for: state)
    }
}
