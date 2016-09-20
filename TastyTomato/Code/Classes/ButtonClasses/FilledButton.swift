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
    
    public func setFillColor(_ color: UIColor) {
        self._setFillColor(color)
    }
    
    public func setHighlightedAlpha(_ alph: CGFloat) {
        self._setHighlightedAlpha(alph)
    }
}


// MARK: Class Declaration
open class FilledButton: BaseButton {
    // Setup Override
    override class func setup_<T: FilledButton>(_ button: T) {
        super.setup_(button)
        button.setFillColor(button.fillColor)
    }
    
    // Private Stored Variable Properties
    fileprivate var _fillColor: UIColor = UIColor.Blue00A7C4()
    fileprivate var _highlightedAlpha: CGFloat = 0.6
}


// MARK: Override
public extension FilledButton {
    override open var frame: CGRect {
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
    func _setFillColor(_ color: UIColor) {
        self._fillColor = color
        
        self.setColor_(
            color,
            forState: UIControlState()
        )
        
        self.setColor_(
            color.withAlpha(self.highlightedAlpha),
            forState: .highlighted
        )
    }
    
    func _setHighlightedAlpha(_ alph: CGFloat) {
        self._highlightedAlpha = alph
        
        self.setColor_(
            self.fillColor.withAlpha(alph),
            forState: .highlighted
        )
    }
}
