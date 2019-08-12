//
//  BaseTextView.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BaseTextView: UITextView {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self._init()
    }
}


// MARK: // Private
// MARK: Common Init
private extension BaseTextView {
    func _init() {
        self.setColorAdjustment({
            $0.layer.borderColor = ColorScheme.lines.borderUnfocussed.cgColor
            let textView: UITextView? = $0 as? UITextView
            textView?.textColor = ColorScheme.text.default
        })
        
        let layer: CALayer = self.layer
        layer.cornerRadius = 4
        layer.borderWidth = 1
        
        self.clipsToBounds = true
        
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.font = .s
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
}
