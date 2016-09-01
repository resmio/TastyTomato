//
//  ShortcutBarButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 9/1/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class ShortcutBarButton: BaseButton {
    // MARK: // Internal
    // MARK: Factory Override
    override class func button_<T: BaseButton>() -> T {
        return self._button()
    }
    
    // Private Constant Stored Properties
    private static let _height: CGFloat = 35
}


// MARK: // Private
// MARK: Factory Override
private extension ShortcutBarButton {
    private static func _button<T: BaseButton>() -> T {
        let button: T = super.button_()
        button.height = self._height
        
        button.setColor(UIColor.GrayCCCCCC(), forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.setColor(UIColor.whiteColor(), forState: .Highlighted)
        button.setTitleColor(UIColor.GrayF7F7F7(), forState: .Highlighted)
        
        button.setColor(UIColor.whiteColor(), forState: .Selected)
        button.setTitleColor(UIColor.GrayF7F7F7(), forState: .Selected)
        
        button.titleLabel!.font = UIFont.systemFontOfSize(17)
        
        return button
    }
}
