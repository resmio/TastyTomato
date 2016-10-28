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
    convenience init?(color: UIColor) {
        self.init(_color: color)
    }
}


// MARK: // Private
private extension UIImage {
    convenience init?(_color: UIColor) {
        let size: CGSize = CGSize(width: 1, height: 1)
        let cgColor: CGColor = _color.cgColor
        let colorIsOpaque: Bool = cgColor.alpha == 1;
        UIGraphicsBeginImageContextWithOptions(size, colorIsOpaque, 1)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        context.setFillColor(cgColor)
        context.fill(size.asCGRect())
        
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        self.init(cgImage: cgImage)
    }
}
