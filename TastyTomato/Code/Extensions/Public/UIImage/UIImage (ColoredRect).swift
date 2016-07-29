//
//  UIImage (ColoredRect).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIImage {
    public static func coloredRect(size size: CGSize, color: UIColor) -> UIImage? {
        return self._coloredRect(
            size: size,
            color: color
        )
    }
}


// MARK: // Private
private extension UIImage {
    private static func _coloredRect(size size: CGSize, color: UIColor) -> UIImage? {
        if size.area != 0 {
            let rect: CGRect = CGRect(size: size)
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context: CGContextRef? = UIGraphicsGetCurrentContext()
            
            CGContextSetFillColorWithColor(context, color.CGColor)
            CGContextFillRect(context, rect)
            
            let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image
        } else {
            return nil
        }
    }
}
