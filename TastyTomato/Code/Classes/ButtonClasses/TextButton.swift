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
    // Private Variable Stored Properties
    private var __underlined: Bool = false
}


// MARK: Overrides
public extension TextButton {
    override public func setTitle(title: String) {
        super.setTitle(title)
        self._updateTitleUnderlining()
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        self._updateTitleUnderlining()
    }
}


// MARK: // Private
// MARK: Computed Properties
private extension TextButton {
    private var _underlined: Bool {
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
    private func _updateTitleUnderlining() {
        if let title: String = self.titleLabel?.text {
            let underlineStyle: NSUnderlineStyle = self.underlined ? .StyleSingle : .StyleNone
            let attributedTitle: NSAttributedString = NSAttributedString(
                string: title,
                attributes: [NSUnderlineStyleAttributeName: underlineStyle.rawValue]
            )
            self.setAttributedTitle(
                attributedTitle,
                forState: .Normal
            )
        }
    }
}
