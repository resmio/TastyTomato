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
        return .systemFont(ofSize: 18)
    }
    
    public static var xl: UIFont {
        return .systemFont(ofSize: 20)
    }
    
    public static var xxl: UIFont {
        return .systemFont(ofSize: 22)
    }
    
    public static var xxxl: UIFont {
        return .systemFont(ofSize: 24)
    }
    
    // Bold
    public static var xxsBold: UIFont {
        return .boldSystemFont(ofSize: 14)
    }
    
    public static var xsBold: UIFont {
        return .boldSystemFont(ofSize: 15)
    }
    
    public static var sBold: UIFont {
        return .boldSystemFont(ofSize: 16)
    }
    
    public static var mBold: UIFont {
        return .boldSystemFont(ofSize: 17)
    }
    
    public static var xxlBold: UIFont {
        return .boldSystemFont(ofSize: 22)
    }
}
