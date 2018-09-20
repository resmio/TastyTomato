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
@objc public extension UIColor {
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
    public static var brown7B4900: UIColor {
        return UIColor(fromHex_: "7B4900")
    }
    
    public static var redBC213F: UIColor {
        return UIColor(fromHex_: "BC213F")
    }
    
    @objc public static var redE62C4F: UIColor {
        return UIColor(fromHex_: "E62C4F")
    }
    
    public static var orangeD97B08: UIColor {
        return UIColor(fromHex_: "D97B08")
    }
    
    public static var orangeFF910A: UIColor {
        return UIColor(fromHex_: "FF910A")
    }
    
    public static var yellowD7A43B: UIColor {
        return UIColor(fromHex_: "D7A43B")
    }
    
    public static var yellowF8C150: UIColor {
        return UIColor(fromHex_: "F8C150")
    }
    
    @objc public static var green22CCAA: UIColor {
        return UIColor(fromHex_: "22CCAA")
    }
    
    public static var green21B498: UIColor {
        return UIColor(fromHex_: "21B498")
    }
    
    @objc public static var blue00A7C4: UIColor {
        return UIColor(fromHex_: "00A7C4")
    }
    
    public static var blue018EA6: UIColor {
        return UIColor(fromHex_: "018EA6")
    }
    
    public static var blue1E2532: UIColor {
        return UIColor(fromHex_: "1E2532")
    }
    
    public static var blue293140: UIColor {
        return UIColor(fromHex_: "293140")
    }
    
    public static var blue333B4F: UIColor {
        return UIColor(fromHex_: "333B4F")
    }
    
    public static var blue3E4862: UIColor {
        return UIColor(fromHex_: "3E4862")
    }
    
    public static var gray222222: UIColor {
        return UIColor(fromHex_: "222222")
    }
    
    @objc public static var gray555555: UIColor {
        return UIColor(fromHex_: "555555")
    }
    
    public static var gray999999: UIColor {
        return UIColor(fromHex_: "999999")
    }
    
    public static var grayCCCCCC: UIColor {
        return UIColor(fromHex_: "CCCCCC")
    }
    
    @objc public static var grayDDDDDD: UIColor {
        return UIColor(fromHex_: "DDDDDD")
    }
    
    public static var grayEEEEEE: UIColor {
        return UIColor(fromHex_: "EEEEEE")
    }
    
    public static var gray3E4862: UIColor {
        return UIColor(fromHex_: "3E4862")
    }
    
    public static var whiteF7F7F7: UIColor {
        return UIColor(fromHex_: "F7F7F7")
    }
    
    public static var whiteFFFFFF: UIColor {
        return UIColor(fromHex_: "FFFFFF")
    }
    
    public static var black000000: UIColor {
        return UIColor(fromHex_: "000000")
    }
    
    public static var purple543EAC: UIColor {
        return UIColor(fromHex_: "543EAC")
    }
    
    public static var pinkFCE9ED: UIColor {
        return UIColor(fromHex_: "FCE9ED")
    }
    
    public static var lightKeyboardBackground: UIColor {
        return UIColor(fromHex_: "D2D5DA")
    }
}
