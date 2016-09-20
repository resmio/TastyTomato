//
//  UIButton (Color).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIButton {
    public func setColor(_ color: UIColor, forState state: UIControlState) {
        self.setColor_(color, forState: state)
    }
}
