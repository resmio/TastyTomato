//
//  FilledButtons.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension FilledButton {
    static func makeDefaultBlueButton(title: String) -> FilledButton {
        return self._makeDefaultBlueButton(title: title)
    }
    
    static func makeSignInButton() -> FilledButton {
        return self._makeDefaultBlueButton(title: NSL_("Sign in"))
    }
    
    static func makeSelectButton() -> FilledButton {
        return self._makeDefaultBlueButton(title: NSL_("Select"))
    }
}


// MARK: // Private
private extension FilledButton {
    static func _makeDefaultBlueButton(title: String) -> FilledButton {
        let button: FilledButton = FilledButton()
        
        button.setTitle(title)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = .s
        button.adjustsWidthOnTitleSet = false
        
        button.height = 44
        
        return button
    }
}
