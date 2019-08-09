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
    var fillColor: UIColor {
        get {
            return self._fillColor
        }
        set(newFillColor) {
            self._fillColor = newFillColor
        }
    }
    
    var highlightedAlpha: CGFloat {
        get {
            return self._highlightedAlpha
        }
        set(newHighlightedAlpha) {
            self._highlightedAlpha = newHighlightedAlpha
        }
    }
}


// MARK: Class Declaration
public class FilledButton: BaseButton {
    // Private Variables
    private var _fillColor: UIColor = .blue00A7C4 {
        didSet {
            self._updateNormalColor()
            self._updateHighlightedColor()
        }
    }
    
    private var _highlightedAlpha: CGFloat = 0.6 {
        didSet { self._updateHighlightedColor() }
    }
    
    // Setup Override
    public override func setup() {
        self._setup()
    }
}


// MARK: // Private
// MARK: Setup Override Implementation
private extension FilledButton {
    func _setup() {
        super.setup()
        self._updateNormalColor()
        self._updateHighlightedColor()
    }
}


// MARK: Update Color Helpers
private extension FilledButton {
    func _updateNormalColor() {
        self.setColor(
            self.fillColor,
            for: .normal
        )
    }
    
    func _updateHighlightedColor() {
        self.setColor(
            self.fillColor.withAlpha(self.highlightedAlpha),
            for: .highlighted
        )
    }
}
