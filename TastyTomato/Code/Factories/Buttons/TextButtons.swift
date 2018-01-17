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
    public static func makeForgotPasswordButton() -> TextButton {
        return self._makeForgotPasswordButton()
    }
}


// MARK: // Private
private extension TextButton {
    static func _makeForgotPasswordButton() -> TextButton {
        let button: TextButton = TextButton()
        
        button.adjustsWidthOnTitleSet = false
        button.setTitleColor(.gray555555, for: .normal)
        button.titleLabel!.font = .xxs
        button.setTitle(NSL_("Forgotten your password?"))
        button.underlined = true
        
        button.sizeToFit()
        
        return button
    }
}
