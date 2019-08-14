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
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    // Init
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        self._init()
    }
    
    // Placeholder Override
    public override var placeholder: String? {
        get { return self.attributedPlaceholder?.string }
        set { self._setPlaceholder(newValue) }
    }
}


// MARK: // Private
// MARK: Common Init
private extension BaseTextField {
    func _init() {
        self.setColorAdjustment({
            $0.layer.borderColor = ColorScheme.lines.borderUnfocussed.cgColor
            let textField: UITextField? = $0 as? UITextField
            textField?.textColor = ColorScheme.text.default
            
            if let placeholder: String = textField?.placeholder {
                textField?.attributedPlaceholder = NSAttributedString(
                    string: placeholder, attributes: [.foregroundColor: ColorScheme.text.placeholder]
                )
            }
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


// MARK: Set Placeholder
private extension BaseTextField {
    func _setPlaceholder(_ placeholder: String?) {
        guard let placeholder: String = placeholder else {
            self.attributedPlaceholder = nil
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder, attributes: [.foregroundColor: ColorScheme.text.placeholder]
        )
    }
}
