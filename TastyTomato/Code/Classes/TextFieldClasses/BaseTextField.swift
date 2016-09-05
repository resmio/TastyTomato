//
//  BaseTextField.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/26/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BaseTextField: UITextField {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    public init() {
        super.init(frame: CGRectZero)
        self._setup()
    }
}


// MARK: // Private
// MARK: Setup
private extension BaseTextField {
    private func _setup() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.GrayDDDDDD().CGColor
        self.clipsToBounds = true
        
        let paddingViewSize: CGSize = CGSize(width: 10, height: 1)
        self.leftView = UIView(size: paddingViewSize)
        self.leftViewMode = .Always
        
        self.rightView = UIView(size: paddingViewSize)
        self.rightViewMode = .Always
        
        self.font = UIFont.systemFontOfSize(17)
        self.textColor = UIColor.Gray555555()
        self.autocapitalizationType = .None
        self.autocorrectionType = .No
    }
}
