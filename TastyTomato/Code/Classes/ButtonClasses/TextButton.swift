//
//  TextButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Fake Initializer
public func TextButton_() -> TextButton {
    return TextButton.button_()
}


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
    // Setup Override
    override class func setup_<T: TextButton>(_ button: T) {
        super.setup_(button)
        button.setTitleColor(.black, for: .normal)
    }
    
    // Private Variable Stored Properties
    fileprivate var __underlined: Bool = false
    
    
    // Overrides
    override public func setTitle(_ title: String) {
        self._setTitle(title)
    }
    
    override public func setTitle(_ title: String?, for state: UIControlState) {
        self._setTitle(title, for: state)
    }
    
    public override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        self._setTitleColor(color, for: state)
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension TextButton {
    var _underlined: Bool {
        get {
            return self.__underlined
        }
        set(newUnderlined) {
            guard newUnderlined != self.__underlined else { return }
            self.__underlined = newUnderlined
            self._updateTitle()
        }
    }
}


// MARK: Set Title Color
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


// MARK: Set Title
private extension TextButton {
    func _setTitle(_ title: String?, for state: UIControlState = .normal) {
        if title?.isEmpty ?? true {
            self.setAttributedTitle(nil, for: state)
            return
        }
        
        let underlineStyle: NSUnderlineStyle = self.underlined ? .styleSingle : .styleNone
        let titleColor: UIColor = self.titleColor(for: state) ?? .black
        let attributes: [String : Any] = [
            NSForegroundColorAttributeName: titleColor,
            NSUnderlineStyleAttributeName: underlineStyle.rawValue
        ]
        
        let attributedTitle: NSAttributedString = NSAttributedString(
            string: title!,
            attributes: attributes
        )
        
        super.setTitle(title, for: state)
        self.setAttributedTitle(attributedTitle, for: state)
    }
}
