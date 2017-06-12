//
//  UIColor (PredefinedColors).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/8/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// TODO: Define these colors!
// Maybe we can generalize how a color should change when it's highlighted, 
// then we could implement is as a method .highlighted() -> TTColor
public extension UIColor {
    public static func RAColorHighlightedBlue() -> UIColor {
        return self._Blue00A7C4.withAlpha(0.3)
    }
    
    public static func RAColorHighlightedRed() -> UIColor {
        return self._RedE62C4F.withAlpha(0.3)
    }
    
    public static func RAColorSeparator() -> UIColor {
        return self._GrayDDDDDD
    }
}


// MARK: // Public
public extension UIColor {
    public static func RedE62C4F() -> UIColor {
        return self._RedE62C4F
    }
    
    public static func YellowF8C150() -> UIColor {
        return self._YellowF8C150
    }
    
    public static func Green22CCAA() -> UIColor {
        return self._Green22CCAA
    }
    
    public static func Blue00A7C4() -> UIColor {
        return self._Blue00A7C4
    }
    
    public static func Blue018EA6() -> UIColor {
        return self._Blue018EA6
    }
    
    public static func Blue333B4F() -> UIColor {
        return self._Blue333B4F
    }
    
    public static func Gray555555() -> UIColor {
        return self._Gray555555
    }
    
    public static func Gray999999() -> UIColor {
        return self._Gray999999
    }
    
    public static func GrayCCCCCC() -> UIColor {
        return self._GrayCCCCCC
    }
    
    public static func GrayDDDDDD() -> UIColor {
        return self._GrayDDDDDD
    }
    
    public static func GrayF7F7F7() -> UIColor {
        return self._GrayF7F7F7
    }
    
    public static func LightKeyboardBackground() -> UIColor {
        return self._LightKeyboardBackround
    }
}


// MARK: // Private
private extension UIColor {
    static var _RedE62C4F: UIColor {
        return UIColor(fromHex_: "E62C4F")
    }
    
    static var _YellowF8C150: UIColor {
        return UIColor(fromHex_: "F8C150")
    }
    
    static var _Green22CCAA: UIColor {
        return UIColor(fromHex_: "22CCAA")
    }
    
    static var _Blue00A7C4: UIColor {
        return UIColor(fromHex_: "00A7C4")
    }
    
    static var _Blue018EA6: UIColor {
        return UIColor(fromHex_: "018EA6")
    }
    
    static var _Blue333B4F: UIColor {
        return UIColor(fromHex_: "333B4F")
    }
    
    static var _Gray555555: UIColor {
        return UIColor(fromHex_: "555555")
    }
    
    static var _Gray999999: UIColor {
        return UIColor(fromHex_: "999999")
    }
    
    static var _GrayCCCCCC: UIColor {
        return UIColor(fromHex_: "CCCCCC")
    }
    
    static var _GrayDDDDDD: UIColor {
        return UIColor(fromHex_: "DDDDDD")
    }
    
    static var _GrayF7F7F7: UIColor {
        return UIColor(fromHex_: "F7F7F7")
    }
    
    static var _LightKeyboardBackround: UIColor {
        return UIColor(fromHex_: "D2D5DA")
    }
}
