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
    public static var xxxs: UIFont {
        return .systemFont(ofSize: 12)
    }
    
    public static var xxs: UIFont {
        return .systemFont(ofSize: 14)
    }
    
    public static var xs: UIFont {
        return .systemFont(ofSize: 15)
    }
    
    public static var s: UIFont {
        return .systemFont(ofSize: 16)
    }
    
    public static var m: UIFont {
        return .systemFont(ofSize: 17)
    }
    
    public static var l: UIFont {
        return .systemFont(ofSize: 20)
    }
    
    public static var xl: UIFont {
        return .systemFont(ofSize: 22)
    }
    
    public static var xxl: UIFont {
        return .systemFont(ofSize: 24)
    }
    
    // Functions
    public func bold() -> UIFont {
        return .boldSystemFont(ofSize: self.pointSize)
    }
    
    public func normal() -> UIFont {
        return .systemFont(ofSize: self.pointSize)
    }
}
