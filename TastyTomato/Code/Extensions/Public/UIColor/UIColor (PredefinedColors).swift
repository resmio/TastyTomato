//
//  UIColor (PredefinedColors).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/8/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


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
}


// MARK: // Private
private extension UIColor {
    private static let _RedE62C4F: UIColor =    UIColor(fromHex_: "E62C4F")
    private static let _YellowF8C150: UIColor = UIColor(fromHex_: "F8C150")
    private static let _Green22CCAA: UIColor =  UIColor(fromHex_: "22CCAA")
    private static let _Blue00A7C4: UIColor =   UIColor(fromHex_: "00A7C4")
    private static let _Blue018EA6: UIColor =   UIColor(fromHex_: "018EA6")
    private static let _Gray555555: UIColor =   UIColor(fromHex_: "555555")
    private static let _Gray999999: UIColor =   UIColor(fromHex_: "999999")
    private static let _GrayCCCCCC: UIColor =   UIColor(fromHex_: "CCCCCC")
    private static let _GrayDDDDDD: UIColor =   UIColor(fromHex_: "DDDDDD")
    private static let _GrayF7F7F7: UIColor =   UIColor(fromHex_: "F7F7F7")
}
