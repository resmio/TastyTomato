//
//  TextButtons.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension TextButton {
    public static func ForgotPasswordButton() -> TextButton {
        return self._ForgotPasswordButton()
    }
}


// MARK: // Private
private extension TextButton {
    private static func _ForgotPasswordButton() -> TextButton {
        let button: TextButton = self.button_()
        
        button.tintColor = UIColor.Gray555555()
        button.setTitle(NSL_("Forgotten your password?"))
        button.titleLabel!.font = UIFont.systemFontOfSize(14)
        button.underlined = true
        
        button.sizeToFit()
        
        return button
    }
}
