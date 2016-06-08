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
    static var RedE62C4F: UIColor {
        return self._RedE62C4F
    }
    
    static var YellowF8C150: UIColor {
        return self._YellowF8C150
    }
    
    static var Green22CCAA: UIColor {
        return self._Green22CCAA
    }
    
    static var Blue00A7C4: UIColor {
        return self._Blue00A7C4
    }
    
    static var Blue018EA6: UIColor {
        return self._Blue018EA6
    }
    
    static var Gray555555: UIColor {
        return self._Gray555555
    }
    
    static var Gray999999: UIColor {
        return self._Gray999999
    }
    
    static var GrayCCCCCC: UIColor {
        return self._GrayCCCCCC
    }
    
    static var GrayDDDDDD: UIColor {
        return self._GrayDDDDDD
    }
    
    static var GrayF7F7F7: UIColor {
        return self._GrayF7F7F7
    }
}


// MARK: // Private
private extension UIColor {
    private static var _RedE62C4F: UIColor {
        return self.colorFromHex_("E62C4F")
    }
    
    private static var _YellowF8C150: UIColor {
        return self.colorFromHex_("F8C150")
    }
    
    private static var _Green22CCAA: UIColor {
        return self.colorFromHex_("22CCAA")
    }
    
    private static var _Blue00A7C4: UIColor {
        return self.colorFromHex_("00A7C4")
    }
    
    private static var _Blue018EA6: UIColor {
        return self.colorFromHex_("018EA6")
    }
    
    private static var _Gray555555: UIColor {
        return self.colorFromHex_("555555")
    }
    
    private static var _Gray999999: UIColor {
        return self.colorFromHex_("999999")
    }
    
    private static var _GrayCCCCCC: UIColor {
        return self.colorFromHex_("CCCCCC")
    }
    
    private static var _GrayDDDDDD: UIColor {
        return self.colorFromHex_("DDDDDD")
    }
    
    private static var _GrayF7F7F7: UIColor {
        return self.colorFromHex_("F7F7F7")
    }
}
