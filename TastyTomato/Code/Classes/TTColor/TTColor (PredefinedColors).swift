//
//  TTColor (PredefinedColors).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/8/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// TODO: Define these colors!
// Maybe we can generalize how a color should change when it's highlighted, 
// then we could implement is as a method .highlighted() -> TTColor
public extension TTColor {
    public static func RAColorHighlightedBlue() -> TTColor {
        return self._Blue00A7C4
    }
    
    public static func RAColorHighlightedRed() -> TTColor {
        return self._RedE62C4F
    }
    
    public static func RAColorSeparator() -> TTColor {
        return self._GrayDDDDDD
    }
}


// MARK: // Public
public extension TTColor {
    public static func RedE62C4F() -> TTColor {
        return self._RedE62C4F
    }
    
    public static func YellowF8C150() -> TTColor {
        return self._YellowF8C150
    }
    
    public static func Green22CCAA() -> TTColor {
        return self._Green22CCAA
    }
    
    public static func Blue00A7C4() -> TTColor {
        return self._Blue00A7C4
    }
    
    public static func Blue018EA6() -> TTColor {
        return self._Blue018EA6
    }
    
    public static func Gray555555() -> TTColor {
        return self._Gray555555
    }
    
    public static func Gray999999() -> TTColor {
        return self._Gray999999
    }
    
    public static func GrayCCCCCC() -> TTColor {
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
private extension TTColor {
    private static let _RedE62C4F: TTColor =    TTColor(fromHex_: "E62C4F")
    private static let _YellowF8C150: TTColor = TTColor(fromHex_: "F8C150")
    private static let _Green22CCAA: TTColor =  TTColor(fromHex_: "22CCAA")
    private static let _Blue00A7C4: TTColor =   TTColor(fromHex_: "00A7C4")
    private static let _Blue018EA6: TTColor =   TTColor(fromHex_: "018EA6")
    private static let _Gray555555: TTColor =   TTColor(fromHex_: "555555")
    private static let _Gray999999: TTColor =   TTColor(fromHex_: "999999")
    private static let _GrayCCCCCC: TTColor =   TTColor(fromHex_: "CCCCCC")
    private static let _GrayDDDDDD: TTColor =   TTColor(fromHex_: "DDDDDD")
    private static let _GrayF7F7F7: TTColor =   TTColor(fromHex_: "F7F7F7")
}
