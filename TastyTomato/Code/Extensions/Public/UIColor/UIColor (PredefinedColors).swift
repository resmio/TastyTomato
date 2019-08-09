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
    static var highlightedBlue: UIColor {
        return self.blue00A7C4.withAlpha(0.3)
    }
    
    static var highlightedRed: UIColor {
        return self.redE62C4F.withAlpha(0.3)
    }
    
    static var separatorColor: UIColor {
        return self.grayDDDDDD
    }
}


// MARK: // Public
public extension UIColor {
    static var brown7B4900: UIColor {
        return UIColor(fromHex_: "7B4900")
    }
    
    static var redBC213F: UIColor {
        return UIColor(fromHex_: "BC213F")
    }
    
    @objc static var redE62C4F: UIColor {
        return UIColor(fromHex_: "E62C4F")
    }
    
    static var orangeD97B08: UIColor {
        return UIColor(fromHex_: "D97B08")
    }
    
    static var orangeFF910A: UIColor {
        return UIColor(fromHex_: "FF910A")
    }
    
    static var yellowD7A43B: UIColor {
        return UIColor(fromHex_: "D7A43B")
    }
    
    static var yellowF8C150: UIColor {
        return UIColor(fromHex_: "F8C150")
    }
    
    static var yellowFFF1D4: UIColor {
        return UIColor(fromHex_: "FFF1D4")
    }
    
    @objc static var green22CCAA: UIColor {
        return UIColor(fromHex_: "22CCAA")
    }
    
    static var green21B498: UIColor {
        return UIColor(fromHex_: "21B498")
    }
    
    @objc static var blue00A7C4: UIColor {
        return UIColor(fromHex_: "00A7C4")
    }
    
    static var blue018EA6: UIColor {
        return UIColor(fromHex_: "018EA6")
    }
    
    static var blue1E2532: UIColor {
        return UIColor(fromHex_: "1E2532")
    }
    
    static var blue293140: UIColor {
        return UIColor(fromHex_: "293140")
    }
    
    static var blue333B4F: UIColor {
        return UIColor(fromHex_: "333B4F")
    }
    
    static var blue3F4962: UIColor {
        return UIColor(fromHex_: "3F4962")
    }
    
    static var blueC0F6FF: UIColor {
        return UIColor(fromHex_: "C0F6FF")
    }
    
    static var gray222222: UIColor {
        return UIColor(fromHex_: "222222")
    }
    
    @objc static var gray555555: UIColor {
        return UIColor(fromHex_: "555555")
    }
    
    static var gray909295: UIColor {
        return UIColor(fromHex_: "909295")
    }
    
    static var gray999999: UIColor {
        return UIColor(fromHex_: "999999")
    }
    
    static var grayCCCCCC: UIColor {
        return UIColor(fromHex_: "CCCCCC")
    }
    
    @objc static var grayDDDDDD: UIColor {
        return UIColor(fromHex_: "DDDDDD")
    }
    
    static var grayEEEEEE: UIColor {
        return UIColor(fromHex_: "EEEEEE")
    }
    
    static var gray3E4862: UIColor {
        return UIColor(fromHex_: "3E4862")
    }
    
    static var whiteF7F7F7: UIColor {
        return UIColor(fromHex_: "F7F7F7")
    }
    
    static var whiteFFFFFF: UIColor {
        return UIColor(fromHex_: "FFFFFF")
    }
    
    static var black000000: UIColor {
        return UIColor(fromHex_: "000000")
    }
    
    static var purple543EAC: UIColor {
        return UIColor(fromHex_: "543EAC")
    }
    
    static var purple7563BC: UIColor {
        return UIColor(fromHex_: "7563BC")
    }
    
    static var pinkFCE9ED: UIColor {
        return UIColor(fromHex_: "FCE9ED")
    }
    
    static var lightKeyboardBackground: UIColor {
        return UIColor(fromHex_: "D2D5DA")
    }
}
