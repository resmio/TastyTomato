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
        
        button.setColor(.gray999999, for: UIControlState())
        button.setTitleColor(.white, for: UIControlState())
        
        button.setColor(.white, for: .highlighted)
        button.setTitleColor(.black, for: .highlighted)
        
        button.setColor(.white, for: .selected)
        button.setTitleColor(.black, for: .selected)
        
        button.titleLabel!.font = UIFont.systemFont(ofSize: 17)
    }
}
