//
//  ShortcutBarButton.swift
//  TastyTomato
//
//  Created by Jan Nash on 9/1/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Fake Initializer
public func ShortcutBarButton_() -> ShortcutBarButton {
    return ShortcutBarButton.button_()
}


// MARK: Class Declaration
public class ShortcutBarButton: BaseButton {
    // Setup Override
    override class func setup_<T: ShortcutBarButton>(button: T) {
        super.setup_(button)
        
        button.setColor(UIColor.Gray999999(), forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.setColor(UIColor.whiteColor(), forState: .Highlighted)
        button.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        
        button.setColor(UIColor.whiteColor(), forState: .Selected)
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        
        button.titleLabel!.font = UIFont.systemFontOfSize(17)
    }
}
