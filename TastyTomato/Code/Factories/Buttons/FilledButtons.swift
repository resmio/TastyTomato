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
    public static func makeSignInButton() -> FilledButton {
        return self._makeSignInButton()
    }
    
    public static func makeSelectFacilityButton() -> FilledButton {
        return self._makeSelectFacilityButton()
    }
}


// MARK: // Private
private extension FilledButton {
    static func _makeSignInButton() -> FilledButton {
        let signInButton: FilledButton = self._makeSignInAndSelectFacilityButton()
        signInButton.setTitle(NSL_("Sign in"))
        return signInButton
    }
    
    static func _makeSelectFacilityButton() -> FilledButton {
        let selectButton: FilledButton = self._makeSignInAndSelectFacilityButton()
        selectButton.setTitle(NSL_("Select"))
        return selectButton
    }
    
    // Helper
    static func _makeSignInAndSelectFacilityButton() -> FilledButton {
        let button: FilledButton = FilledButton()
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = .s
        button.adjustsWidthOnTitleSet = false
        
        button.height = 44
        button.width = 330
        
        return button
    }
}
