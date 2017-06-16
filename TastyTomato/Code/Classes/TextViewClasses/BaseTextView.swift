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
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self._setup()
    }
}


// MARK: // Private
// MARK: Setup
private extension BaseTextView {
    func _setup() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.grayDDDDDD.cgColor
        self.clipsToBounds = true
        
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = .gray555555
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
}
