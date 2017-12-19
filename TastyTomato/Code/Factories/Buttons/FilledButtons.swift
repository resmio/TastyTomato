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
    public static func SignInButton() -> FilledButton {
        return self._SignInButton()
    }
    
    public static func SelectFacilityButton() -> FilledButton {
        return self._SelectFacilityButton()
    }
}


// MARK: // Private
// MARK: Predefined Instances
private extension FilledButton {
    static func _SignInAndSelectFacilityButton() -> FilledButton {
        let button: FilledButton = FilledButton()
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 16)
        button.adjustsWidthOnTitleSet = false
        
        button.height = 44
        button.width = 330
        
        return button
    }
    
    static func _SignInButton() -> FilledButton {
        let signInButton: FilledButton = self._SignInAndSelectFacilityButton()
        signInButton.setTitle(NSL_("Sign in"))
        return signInButton
    }
    
    static func _SelectFacilityButton() -> FilledButton {
        let selectButton: FilledButton = self._SignInAndSelectFacilityButton()
        selectButton.setTitle(NSL_("Select"))
        return selectButton
    }
}
