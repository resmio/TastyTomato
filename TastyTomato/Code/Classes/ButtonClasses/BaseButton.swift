//
//  BaseButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/27/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Fake Initializer
public func BaseButton_() -> BaseButton {
    return BaseButton.button_()
}


// MARK: Factory
public extension BaseButton {
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
    // Init Error Message
    @noreturn class func initErrorMessage() {
        fatalError(
            "Do not initialize \(self.classForCoder) directly. " +
            "Use \(self.classForCoder)_() function instead."
        )
    }
    
    // Privatize Init
    private init() {
        self.dynamicType.initErrorMessage()
    }
    
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
    private static func _button<T: UIButton>() -> T {
        let button = T.init(type: .System)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }
}
