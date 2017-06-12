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
    public static var highlightedBlue: UIColor {
        return self.blue00A7C4.withAlpha(0.3)
    }
    
    public static var highlightedRed: UIColor {
        return self.redE62C4F.withAlpha(0.3)
    }
    
    public static var separatorColor: UIColor {
        return self.grayDDDDDD
    }
}


// MARK: // Public
public extension UIColor {
    public static var redE62C4F: UIColor {
        return self._redE62C4F
    }
    
    public static var yellowF8C150: UIColor {
        return self._yellowF8C150
    }
    
    public static var green22CCAA: UIColor {
        return self._green22CCAA
    }
    
    public static var blue00A7C4: UIColor {
        return self._blue00A7C4
    }
    
    public static var blue018EA6: UIColor {
        return self._blue018EA6
    }
    
    public static var blue333B4F: UIColor {
        return self._blue333B4F
    }
    
    public static var gray555555: UIColor {
        return self._gray555555
    }
    
    public static var gray999999: UIColor {
        return self._gray999999
    }
    
    public static var grayCCCCCC: UIColor {
        return self._grayCCCCCC
    }
    
    public static var grayDDDDDD: UIColor {
        return self._grayDDDDDD
    }
    
    public static var whiteF7F7F7: UIColor {
        return self._whiteF7F7F7
    }
    
    public static var lightKeyboardBackground: UIColor {
        return self._lightKeyboardBackround
    }
}


// MARK: // Private
private extension UIColor {
    static var _redE62C4F: UIColor {
        return UIColor(fromHex_: "E62C4F")
    }
    
    static var _yellowF8C150: UIColor {
        return UIColor(fromHex_: "F8C150")
    }
    
    static var _green22CCAA: UIColor {
        return UIColor(fromHex_: "22CCAA")
    }
    
    static var _blue00A7C4: UIColor {
        return UIColor(fromHex_: "00A7C4")
    }
    
    static var _blue018EA6: UIColor {
        return UIColor(fromHex_: "018EA6")
    }
    
    static var _blue333B4F: UIColor {
        return UIColor(fromHex_: "333B4F")
    }
    
    static var _gray555555: UIColor {
        return UIColor(fromHex_: "555555")
    }
    
    static var _gray999999: UIColor {
        return UIColor(fromHex_: "999999")
    }
    
    static var _grayCCCCCC: UIColor {
        return UIColor(fromHex_: "CCCCCC")
    }
    
    static var _grayDDDDDD: UIColor {
        return UIColor(fromHex_: "DDDDDD")
    }
    
    static var _whiteF7F7F7: UIColor {
        return UIColor(fromHex_: "F7F7F7")
    }
    
    static var _lightKeyboardBackround: UIColor {
        return UIColor(fromHex_: "D2D5DA")
    }
}
