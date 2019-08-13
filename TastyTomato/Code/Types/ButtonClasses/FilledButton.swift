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
    static func makeBlueButton(title: String) -> FilledButton {
        return ._makeBlueButton(title: title)
    }
    
    static func makeSignInButton() -> FilledButton {
        return .makeBlueButton(title: NSL_("Sign in"))
    }
    
    static func makeSelectButton() -> FilledButton {
        return .makeBlueButton(title: NSL_("Select"))
    }
    
    static func makeCreateButton() -> FilledButton {
        return ._makeCreateButton()
    }
    
    static func makeDeleteButton() -> FilledButton {
        return ._makeDeleteButton()
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
    static func _makeBlueButton(title: String) -> FilledButton {
        let button: FilledButton = ._makeDefaultButton(title: title)
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
    
    static func _makeCreateButton() -> FilledButton {
        let button: FilledButton = ._makeDefaultButton(title: NSL_("Create"))
        button.titleLabel!.font = .xs
        button.setColorAdjustment({
            guard let filledButton: FilledButton = $0 as? FilledButton else { return }
            let fillColor: UIColor = ColorScheme.background.createButton
            filledButton.setColor(fillColor, for: .normal)
            filledButton.setColor(fillColor.withAlpha(filledButton.highlightedAlpha), for: .highlighted)
            filledButton.setTitleColor(ColorScheme.text.filledButton, for: .normal)
        })
        return button
    }
    
    static func _makeDeleteButton() -> FilledButton {
        let button: FilledButton = ._makeDefaultButton(title: NSL_("Delete"))
        button.titleLabel!.font = .xs
        button.setColorAdjustment({
            guard let filledButton: FilledButton = $0 as? FilledButton else { return }
            let fillColor: UIColor = ColorScheme.background.deleteButton
            filledButton.setColor(fillColor, for: .normal)
            filledButton.setColor(fillColor.withAlpha(filledButton.highlightedAlpha), for: .highlighted)
            filledButton.setTitleColor(ColorScheme.text.filledButton, for: .normal)
        })
        return button
    }
    
    static func _makeDefaultButton(title: String) -> FilledButton {
        let button: FilledButton = FilledButton()
        button.setTitle(title)
        button.titleLabel!.font = .s
        button.adjustsWidthOnTitleSet = false
        button.height = 44
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
