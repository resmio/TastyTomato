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
    override class func setup_<T: ShortcutBarButton>(_ button: T) {
        super.setup_(button)
        
        button.setColor(UIColor.Gray999999(), for: UIControlState())
        button.setTitleColor(UIColor.white, for: UIControlState())
        
        button.setColor(UIColor.white, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .highlighted)
        
        button.setColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.black, for: .selected)
        
        button.titleLabel!.font = UIFont.systemFont(ofSize: 17)
    }
}
