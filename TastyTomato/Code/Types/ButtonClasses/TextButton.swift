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
    // Factories
    static func makeForgotPasswordButton() -> TextButton {
        return ._makeForgotPasswordButton()
    }
    
    static func makeSaveButton() -> TextButton {
        return ._makeSaveButton()
    }
    
    static func makeCancelButton() -> TextButton {
        return ._makeCancelButton()
    }
    
    // ReadWrite
    var highlightedAlpha: CGFloat {
        get { return self._highlightedAlpha }
        set { self._highlightedAlpha = newValue }
    }
    
    var underlined: Bool {
        get { return self._underlined }
        set { self._underlined = newValue }
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
    public override func setTitle(_ title: String?, for state: State) {
        self._setTitle(title, for: state)
    }
    
    // setTitleColor Override
    public override func setTitleColor(_ color: UIColor?, for state: State) {
        self._setTitleColor(color, for: state)
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension TextButton {
    var _highlightedAlpha: CGFloat {
        get { return self.__highlightedAlpha }
        set(newHighlightedAlpha) {
            guard newHighlightedAlpha != self.__highlightedAlpha else { return }
            self.__highlightedAlpha = newHighlightedAlpha
            let titleColor: UIColor = self.titleColor(for: .highlighted) ?? .black
            let highlightedTitleColor: UIColor = titleColor.withAlpha(self.highlightedAlpha)
            self.setTitleColor(highlightedTitleColor, for: .highlighted)
        }
    }
    
    var _underlined: Bool {
        get { return self.__underlined }
        set(newUnderlined) {
            guard newUnderlined != self.__underlined else { return }
            self.__underlined = newUnderlined
            self._updateAttributedTitle(for: self.state)
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
    func _setTitle(_ title: String?, for state: State) {
        super.setTitle(title, for: state)
        self._setAttributedTitle(title, for: state)
    }
}


// MARK: setTitleColor Override Implementation
private extension TextButton {
    func _setTitleColor(_ color: UIColor?, for state: State) {
        super.setTitleColor(color, for: state)
        if state == .normal {
            super.setTitleColor(color?.withAlpha(self.highlightedAlpha), for: .highlighted)
        }
        self._updateAttributedTitle(for: state)
    }
}


// MARK: Update Title
private extension TextButton {
    func _updateAttributedTitle(for state: State) {
        let title: String? = super.title(for: state)
        self._setAttributedTitle(title, for: state)
    }
}


// MARK: Set Attributed Title
private extension TextButton {
    func _setAttributedTitle(_ title: String?, for state: State) {
        guard let title: String = title else {
            self.setAttributedTitle(nil, for: state)
            return
        }
        
        self.setAttributedTitle(
            self._createAttributedTitle(from: title, for: state),
            for: state
        )
        
        for otherState in UIControl.State._states {
            guard otherState != state else { continue }
            self.setAttributedTitle(
                self._createAttributedTitle(for: otherState),
                for: otherState
            )
        }
    }
    
    // Helper
    func _createAttributedTitle(from title: String? = nil, for state: State) -> NSAttributedString? {
        guard let color: UIColor = super.titleColor(for: state) else { return nil }
        guard let title: String = title ?? super.title(for: state) else { return nil }
        
        let underlineStyle: NSUnderlineStyle = self.underlined ? .single : []
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: color,
            .underlineStyle: underlineStyle.rawValue,
            .underlineColor: color
        ]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
}


// MARK: Factory Implementations
private extension TextButton {
    static func _makeForgotPasswordButton() -> TextButton {
        let button: TextButton = TextButton()
        button.setColorAdjustment({
            ($0 as? TextButton)?.setTitleColor(ColorScheme.text.default, for: .normal)
        })
        button.adjustsWidthOnTitleSet = false
        button.titleLabel!.font = .xs
        button.setTitle(NSL_("Forgotten your password?"))
        button.underlined = true
        button.sizeToFit()
        return button
    }
    
    static func _makeSaveButton() -> TextButton {
        let button: TextButton = ._makeDefaultButton()
        button.setColorAdjustment({
            ($0 as? TextButton)?.setTitleColor(ColorScheme.text.saveButton, for: .normal)
        })
        button.setTitle(NSL_("Save"))
        button.sizeToFit()
        return button
    }
    
    static func _makeCancelButton() -> TextButton {
        let button: TextButton = ._makeDefaultButton()
        button.setColorAdjustment({
            ($0 as? TextButton)?.setTitleColor(ColorScheme.text.cancelButton, for: .normal)
        })
        button.setTitle(NSL_("Cancel"))
        button.sizeToFit()
        return button
    }
    
    static func _makeDefaultButton() -> TextButton {
        let button: TextButton = TextButton()
        button.adjustsWidthOnTitleSet = false
        button.titleLabel!.font = .m
        return button
    }
}


// MARK: - UIControlState
// MARK: _states extension
private extension UIControl.State {
    static var _states: [UIControl.State] = [.normal, .highlighted, .disabled, .selected]
}
