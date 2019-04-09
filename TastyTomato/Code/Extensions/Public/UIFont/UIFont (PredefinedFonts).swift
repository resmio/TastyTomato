//
//  UIFont (PredefinedFonts).swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 17.01.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
@objc public extension UIFont {
    static var xxs: UIFont {
        return .systemFont(ofSize: 12)
    }
    
    static var xs: UIFont {
        return .systemFont(ofSize: 14)
    }
    
    static var s: UIFont {
        return .systemFont(ofSize: 16)
    }
    
    static var m: UIFont {
        return .systemFont(ofSize: 18)
    }
    
    static var l: UIFont {
        return .systemFont(ofSize: 20)
    }
    
    static var xl: UIFont {
        return .systemFont(ofSize: 22)
    }
    
    static var xxl: UIFont {
        return .systemFont(ofSize: 24)
    }
    
    // Functions
    func bold() -> UIFont {
        return .boldSystemFont(ofSize: self.pointSize)
    }
    
    func normal() -> UIFont {
        return .systemFont(ofSize: self.pointSize)
    }
}
