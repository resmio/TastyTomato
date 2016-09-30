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
open class TextButton: BaseButton {
    // Setup Override
    override class func setup_<T: TextButton>(_ button: T) {
        super.setup_(button)
        button.setTitleColor(UIColor.black, for: UIControlState())
    }
    
    // Private Variable Stored Properties
    fileprivate var __underlined: Bool = false
}


// MARK: Overrides
public extension TextButton {
    override public func setTitle(_ title: String) {
        super.setTitle(title)
        self._updateTitleUnderlining()
    }
    
    override open func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        self._updateTitleUnderlining()
    }
}


// MARK: // Private
// MARK: Computed Properties
private extension TextButton {
    var _underlined: Bool {
        get {
            return self.__underlined
        }
        set(newUnderlined) {
            if self.__underlined != newUnderlined {
                self.__underlined = newUnderlined
                self._updateTitleUnderlining()
            }
        }
    }
}


// MARK: Update Underlining
private extension TextButton {
    func _updateTitleUnderlining() {
        if let title: String = self.titleLabel?.text {
            let underlineStyle: NSUnderlineStyle = self.underlined ? .styleSingle : .styleNone
            let attributedTitle: NSAttributedString = NSAttributedString(
                string: title,
                attributes: [NSUnderlineStyleAttributeName: underlineStyle.rawValue]
            )
            self.setAttributedTitle(
                attributedTitle,
                for: UIControlState()
            )
        }
    }
}
