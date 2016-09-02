//
//  FilledButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Fake Initializer
public func FilledButton_() -> FilledButton {
    return FilledButton.button_()
}


// MARK: Interface
public extension FilledButton {
    public var fillColor: UIColor {
        return self._fillColor
    }
    
    public var highlightedAlpha: CGFloat {
        return self._highlightedAlpha
    }
    
    public func setFillColor(color: UIColor) {
        self._setFillColor(color)
    }
    
    public func setHighlightedAlpha(alph: CGFloat) {
        self._setHighlightedAlpha(alph)
    }
}


// MARK: Class Declaration
public class FilledButton: BaseButton {
    // Private Stored Variable Properties
    private var _fillColor: UIColor = UIColor.Blue00A7C4()
    private var _highlightedAlpha: CGFloat = 0.6
}


// MARK: Override
public extension FilledButton {
    override public var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            super.frame = newFrame
            
            // If the old frame was of size zero, we need to set 
            // the color again because it no-ps if the size is zero.
            self.setFillColor(self.fillColor)
        }
    }
}


// MARK: // Private
// MARK: // Interface
private extension FilledButton {
    private func _setFillColor(color: UIColor) {
        self._fillColor = color
        
        self.setColor_(
            color,
            forState: .Normal
        )
        
        self.setColor_(
            color.withAlpha(self.highlightedAlpha),
            forState: .Highlighted
        )
    }
    
    private func _setHighlightedAlpha(alph: CGFloat) {
        self._highlightedAlpha = alph
        
        self.setColor_(
            self.fillColor.withAlpha(alph),
            forState: .Highlighted
        )
    }
}
