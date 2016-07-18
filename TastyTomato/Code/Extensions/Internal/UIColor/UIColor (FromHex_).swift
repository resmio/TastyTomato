//
//  UIColor (FromHex_).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/8/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Internal
extension UIColor {
    // Input strings should be 6-character Hex strings without the #
    convenience init(fromHex_ hexString: String, withAlpha alpha: CGFloat = 1) {
        self.init(
            _fromHex: hexString,
            withAlpha: alpha
        )
    }
}


// MARK: // Private
private extension UIColor {
    private convenience init(_fromHex hexString: String, withAlpha alpha: CGFloat) {
        let scanner: NSScanner = NSScanner(string: hexString)
        var rgbValue: UInt32 = 0
        scanner.scanHexInt(&rgbValue)
        
        let red: CGFloat = CGFloat((rgbValue & 0xFF0000) >> 16) / CGFloat(255)
        let green: CGFloat = CGFloat((rgbValue & 0xFF00) >> 8) / CGFloat(255)
        let blue: CGFloat = CGFloat((rgbValue & 0xFF) >> 0) / CGFloat(255)
        
        self.init(
            red: red,
            green: green,
            blue: blue,
            alpha: alpha
        )
    }
}
