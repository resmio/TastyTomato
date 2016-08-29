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
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    public convenience init() {
        self.init()
        self._setup()
    }
}


// MARK: // Private
// MARK: Setup
private extension BaseTextView {
    private func _setup() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.GrayDDDDDD().CGColor
        self.clipsToBounds = true
        
        self.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        self.font = UIFont.systemFontOfSize(17)
        self.textColor = UIColor.Gray555555()
        self.autocapitalizationType = .None
        self.autocorrectionType = .No
    }
}
