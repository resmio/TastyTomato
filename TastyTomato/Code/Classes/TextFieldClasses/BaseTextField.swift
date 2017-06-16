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
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._setup()
    }
}


// MARK: // Private
// MARK: Setup
private extension BaseTextField {
    func _setup() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.grayDDDDDD.cgColor
        self.clipsToBounds = true
        
        let paddingViewSize: CGSize = CGSize(width: 10, height: 1)
        self.leftView = UIView(size: paddingViewSize)
        self.leftViewMode = .always
        
        self.rightView = UIView(size: paddingViewSize)
        self.rightViewMode = .always
        
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = .gray555555
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
}
