//
//  BaseButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/27/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
public extension BaseButton {
    // ReadWrite
    public var adjustsWidthOnTitleSet: Bool {
        get {
            return self._adjustsWidthOnTitleSet
        }
        set(newAdjustsWidthOnTitleSet) {
            self._adjustsWidthOnTitleSet = newAdjustsWidthOnTitleSet
        }
    }
    
    public var xPadding: CGFloat {
        get {
            return self._xPadding
        }
        set(newXPadding) {
            self._xPadding = newXPadding
        }
    }
    
    public var yPadding: CGFloat {
        get {
            return self._yPadding
        }
        set(newYPadding) {
            self._yPadding = newYPadding
        }
    }
}


// MARK: Class Declaration
public class BaseButton: UIButton {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // Override Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public convenience init() {
        self.init(frame: .zero)
        self.setup()
    }
    
    // Private Constants
    private let _minimumSideLength: CGFloat = 44
    
    // Private Variables
    private var _adjustsWidthOnTitleSet: Bool = true
    private var __XPadding: CGFloat = 10
    private var __YPadding: CGFloat = 10
    
    // Layout Overrides
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self._sizeThatFits(size)
    }
    
    // setTitle Overrides
    public func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }
    
    public override func setTitle(_ title: String?, for state: UIControlState) {
        self._setTitle(title, for: state)
    }
    
    // Setup
    public func setup() {
        self._setup()
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension BaseButton {
    var _xPadding: CGFloat {
        get {
            return self.__XPadding
        }
        set(newXPadding) {
            guard newXPadding != self.__XPadding else { return }
            self.__XPadding = newXPadding
            self.sizeToFit()
        }
    }
    
    var _yPadding: CGFloat {
        get {
            return self.__YPadding
        }
        set(newYPadding) {
            guard newYPadding != self.__YPadding else { return }
            self.__YPadding = newYPadding
            self.sizeToFit()
        }
    }
}


// MARK: Setup Implementation
private extension BaseButton {
    func _setup() {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
}


// MARK: Layout Override Implementations
private extension BaseButton {
    func _sizeThatFits(_ size: CGSize) -> CGSize {
        var size: CGSize = super.sizeThatFits(size)
        let widthWithPadding: CGFloat = size.width + (2 * self.xPadding)
        let heightWithPadding: CGFloat = size.height + (2 * self.yPadding)
        size.width = max(widthWithPadding, self._minimumSideLength)
        size.height = max(heightWithPadding, self._minimumSideLength)
        return size
    }
}


// MARK: setTitle Override Implementation
private extension BaseButton {
    func _setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        if self.adjustsWidthOnTitleSet {
            self.width = self.sizeThatFits(.zero).width
        }
    }
}
