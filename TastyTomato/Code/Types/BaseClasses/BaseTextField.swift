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
        self._init()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        self._init()
    }
    
    // Common Init
    private func _init() {
        self.setColorAdjustment({
            $0.layer.borderColor = ColorScheme.lines.borderUnfocussed.cgColor
            ($0 as? UITextField)?.textColor = ColorScheme.text.default
        })
        
        let layer: CALayer = self.layer
        layer.cornerRadius = 4
        layer.borderWidth = 1
        self.clipsToBounds = true
        
        let paddingViewSize: CGSize = CGSize(width: 10, height: 1)
        self.leftView = UIView(size: paddingViewSize)
        self.leftViewMode = .always
        
        self.rightView = UIView(size: paddingViewSize)
        self.rightViewMode = .always
        
        self.font = .s
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
}
