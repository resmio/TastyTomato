//
//  UIImage (withTint).swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 19.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit
import QuartzCore


// MARK: // Public
public extension UIImage {
    func withTint(color: UIColor) -> UIImage? {
        return self._withTint(color: color)
    }
}


// MARK: // Private
private extension UIImage {
    func _withTint(color: UIColor) -> UIImage? {
        let size: CGSize = self.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage: CGImage = self.cgImage, let context: CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -size.height)
        
        let drawRect: CGRect = size.asCGRect()
        context.clip(to: drawRect, mask: cgImage)
        color.setFill()
        UIRectFill(drawRect)
        self.draw(in: drawRect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
