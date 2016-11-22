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


// MARK: Interface
public extension BaseButton {
    // Readonly
    public static var defaultWidth: CGFloat {
        return self._defaultWidth
    }
    
    public static var defaultHeight: CGFloat {
        return self._defaultHeight
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
    // Init Error Message
    class func initErrorMessage() -> Never  {
        fatalError(
            "Do not initialize \(self.classForCoder) directly. " +
            "Use \(self.classForCoder)_() function instead."
        )
    }
    
    // Initialization
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override internal init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate init() {
        type(of: self).initErrorMessage()
    }
    
    // Factory
    static func button_() -> Self {
        return self._button()
    }
    
    // Setup
    class func setup_<T: BaseButton>(_ button: T) {
        self._setup(button)
    }
    
    // Private Static Constant Stored Properties
    fileprivate static let _defaultWidth: CGFloat = 100
    fileprivate static let _defaultHeight: CGFloat = 35
    
    // Private Constants Stored Properties
    fileprivate let _horizontalPadding: CGFloat = 10
    
    // Private Variable Stored Properties
    fileprivate var _autoAdjustWidthOnTitleSet: Bool = true
}


// MARK: Override
extension BaseButton {
    override public func setTitle(_ title: String) {
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
    static func _button() -> Self {
        let button = self.init(type: .system)
        type(of: button).setup_(button)
        return button
    }
}


// MARK: Setup
private extension BaseButton {
    static func _setup<T: BaseButton>(_ button: T) {
        button.height = self.defaultHeight
        button.width = self.defaultWidth
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
    }
}
