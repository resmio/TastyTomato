//
//  UIImage (ColoredRect).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        self.init(_color: color, _size: size)
    }
}


// MARK: // Private
private extension UIImage {
    convenience init?(_color: UIColor, _size: CGSize) {
        guard _size.area != 0 else {
            return nil
        }
        
        let cgColor: CGColor = _color.cgColor
        let colorIsOpaque: Bool = cgColor.alpha == 1;
        UIGraphicsBeginImageContextWithOptions(_size, colorIsOpaque, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        let rect: CGRect = _size.asCGRect()
        context.setFillColor(cgColor)
        context.fill(rect)
        
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        self.init(cgImage: cgImage)
    }
}
