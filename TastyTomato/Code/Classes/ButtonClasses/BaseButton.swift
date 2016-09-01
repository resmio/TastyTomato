//
//  BaseButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/27/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Factory
public extension BaseButton {
    @nonobjc public static func Button<T: BaseButton>() -> T {
        return self._button()
    }
    
    @objc public static func Button() -> BaseButton {
        return self._button()
    }
    
    public var autoAdjustWidthOnTitleSet: Bool {
        get {
            return self._autoAdjustWidthOnTitleSet
        }
        set(newAutoAdjustWidthOnTitleSet) {
            self._autoAdjustWidthOnTitleSet = newAutoAdjustWidthOnTitleSet
        }
    }
}


// MARK: Class Declaration
public class BaseButton: UIButton {
    // // Internal
    // Factory
    class func button_<T: BaseButton>() -> T {
        return self._button()
    }
    
    // Private Constants Stored Properties
    private let _horizontalPadding: CGFloat = 10
    
    // Private Variable Stored Properties
    private var _autoAdjustWidthOnTitleSet: Bool = true
}


// MARK: Override
extension BaseButton {
    override public func setTitle(title: String) {
        super.setTitle(title)
        if self.autoAdjustWidthOnTitleSet {
            let backupHeight: CGFloat = self.height
            self.sizeToFit()
            self.width += 2 * self._horizontalPadding
            self.height = backupHeight
        }
    }
}


// MARK: // Private
// MARK: Factory
private extension BaseButton {
    private static func _button<T: BaseButton>() -> T {
        let button = T.init(type: .System)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }
}
