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
    private static func _SignInButton() -> FilledButton {
        let signInButton: FilledButton = self.button_()
        
        signInButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signInButton.titleLabel!.font = UIFont.systemFontOfSize(16)
        
        signInButton.heightInGlobalUnits = 0.7
        signInButton.widthInGlobalUnits = 5.1
        
        return signInButton
    }
    
    private static func _SelectFacilityButton() -> FilledButton {
        return self.SignInButton()
    }
}
