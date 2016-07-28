//
//  UIImage (Scaled).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIImage {
    public func scaledByFactor(factor: CGFloat) -> UIImage {
        return self._scaledByFactor(factor)
    }
    
    public func scaledToSize(size: CGSize) -> UIImage {
        return self._scaledToSize(size)
    }
}


// MARK: // Private
private extension UIImage {
    private func _scaledByFactor(factor: CGFloat) -> UIImage {
        return self._scaledToSize(self.size.scaledByFactor(factor))
    }
    
    private func _scaledToSize(size: CGSize) -> UIImage {
        // In the next line, pass 0.0 to use 
        // the current device's pixel scaling factor
        // (and thus account for Retina resolution).
        // Pass 1.0 to force exact pixel size.
        let renderingMode: UIImageRenderingMode = self.renderingMode
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let newImageWithRenderingMode: UIImage = newImage.imageWithRenderingMode(renderingMode)
        return newImageWithRenderingMode
    }
}
