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
    public var highlightedAlpha: CGFloat {
        get {
            return self._highlightedAlpha
        }
        set(newHighlightedAlpha) {
            self._highlightedAlpha = newHighlightedAlpha
        }
    }
    
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
    private var __highlightedAlpha: CGFloat = 0.5
    private var __underlined: Bool = false
    
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
// MARK: Computed Variables
private extension TextButton {
    var _highlightedAlpha: CGFloat {
        get {
            return self.__highlightedAlpha
        }
        set(newHighlightedAlpha) {
            guard newHighlightedAlpha != self.__highlightedAlpha else { return }
            self.__highlightedAlpha = newHighlightedAlpha
            let titleColor: UIColor = self.titleColor(for: .highlighted) ?? .black
            let highlightedTitleColor: UIColor = titleColor.withAlpha(self.highlightedAlpha)
            self.setTitleColor(highlightedTitleColor, for: .highlighted)
        }
    }
    
    var _underlined: Bool {
        get {
            return self.__underlined
        }
        set(newUnderlined) {
            guard newUnderlined != self.__underlined else { return }
            self.__underlined = newUnderlined
            self._updateAttributedTitle(for: state)
        }
    }
}


// MARK: Setup Override Implementation
private extension TextButton {
    func _setup() {
        super.setup()
        self.xPadding = 0
        self.yPadding = 0
    }
}


// MARK: setTitle Override Implementation
private extension TextButton {
    func _setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        self._setAttributedTitle(title, for: state)
    }
}


// MARK: setTitleColor Override Implementation
private extension TextButton {
    func _setTitleColor(_ color: UIColor?, for state: UIControlState) {
        super.setTitleColor(color, for: state)
        if state == .normal {
            super.setTitleColor(color?.withAlpha(self.highlightedAlpha), for: .highlighted)
        }
        self._updateAttributedTitle(for: state)
    }
}


// MARK: Update Title
private extension TextButton {
    func _updateAttributedTitle(for state: UIControlState) {
        let title: String? = super.title(for: state)
        self._setAttributedTitle(title, for: state)
    }
}


// MARK: Set Attributed Title
private extension TextButton {
    func _setAttributedTitle(_ title: String?, for state: UIControlState) {
        guard let title: String = title else {
            self.setAttributedTitle(nil, for: state)
            return
        }
        
        self.setAttributedTitle(
            self._createAttributedTitle(from: title, for: state),
            for: state
        )
        
        for otherState in UIControlState._states {
            guard otherState != state else { continue }
            self.setAttributedTitle(
                self._createAttributedTitle(for: otherState),
                for: otherState
            )
        }
    }
    
    // Helper
    func _createAttributedTitle(from title: String? = nil, for state: UIControlState) -> NSAttributedString? {
        guard let color: UIColor = super.titleColor(for: state) else { return nil }
        guard let title: String = title ?? super.title(for: state) else { return nil }
        
        let underlineStyle: NSUnderlineStyle = self.underlined ? .styleSingle : .styleNone
        let attributes: [NSAttributedStringKey : Any] = [
            .foregroundColor: color,
            .underlineStyle: underlineStyle.rawValue,
            .underlineColor: color
        ]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
}


// MARK: - UIControlState
// MARK: _states extension
private extension UIControlState {
    static var _states: [UIControlState] = [.normal, .highlighted, .disabled, .selected]
}
