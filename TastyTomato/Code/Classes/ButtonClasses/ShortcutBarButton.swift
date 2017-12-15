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
    // Setup Override
    public override func setup() {
        self._setup()
    }
}


// MARK: // Private
// MARK: Setup Override Implementation
private extension ShortcutBarButton {
    func _setup() {
        super.setup()
        
        self.setColor(.gray999999, for: .normal)
        self.setTitleColor(.white, for: .normal)
        
        self.setColor(.white, for: .highlighted)
        self.setTitleColor(.black, for: .highlighted)
        
        self.setColor(.white, for: .selected)
        self.setTitleColor(.black, for: .selected)
        
        self.titleLabel!.font = UIFont.systemFont(ofSize: 17)
    }
}
