//
//  ShortcutBar.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/30/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class ShortcutBar: UIToolbar {
    // Init
    public convenience init() {
        let width: CGFloat = UIScreen.mainScreen().bounds.width
        self.init(frame: CGRect(size: CGSize(width: width, height: 44)))
        self.barTintColor = UIColor.LightKeyboardBackground()
    }
}
