//
//  FilledButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Interface
public extension FilledButton {
    // Factories
    static func makeDefaultButton(title: String) -> FilledButton {
        return ._makeDefaultButton(title: title)
    }
    
    static func makeSignInButton() -> FilledButton {
        return .makeDefaultButton(title: NSL_("Sign in"))
    }
    
    static func makeSelectButton() -> FilledButton {
        return .makeDefaultButton(title: NSL_("Select"))
    }
    
    // Dim
    func dim(_ dim: Bool) {
        self._dim(dim)
    }
}


// MARK: Class Declaration
public class FilledButton: BaseButton {
    // Public Constants
    public let highlightedAlpha: CGFloat = 0.6
    
    // Private Variables
    private var _isDimmed: Bool = false
    private var _fillColor: UIColor = .blue00A7C4
}


// MARK: // Private
// MARK: Factories
private extension FilledButton {
    static func _makeDefaultButton(title: String) -> FilledButton {
        let button: FilledButton = FilledButton()
        button.setTitle(title)
        button.titleLabel!.font = .s
        button.adjustsWidthOnTitleSet = false
        button.height = 44
        
        button.setColorAdjustment({
            guard let filledButton: FilledButton = $0 as? FilledButton else { return }
            let background: ColorScheme.Background = ColorScheme.background
            let dimmed: Bool = filledButton._isDimmed
            let fillColor: UIColor = dimmed ? background.filledButtonDimmed : background.filledButton
            filledButton.setColor(fillColor, for: .normal)
            filledButton.setColor(fillColor.withAlpha(filledButton.highlightedAlpha), for: .highlighted)
            filledButton.setTitleColor(ColorScheme.text.filledButton, for: .normal)
        })
        
        return button
    }
}


// MARK: Dim Implementation
private extension FilledButton {
    func _dim(_ dim: Bool) {
        guard dim != self._isDimmed else { return }
        self._isDimmed = dim
        self.adjustColors()
    }
}
