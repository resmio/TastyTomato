//
//  UIImage (Scaled).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIImage {
    public func scaledByFactor(_ factor: CGFloat) -> UIImage {
        return self._scaledByFactor(factor)
    }
    
    public func scaledToSize(_ size: CGSize) -> UIImage {
        return self._scaledToSize(size)
    }
}


// MARK: // Private
private extension UIImage {
    func _scaledByFactor(_ factor: CGFloat) -> UIImage {
        return self._scaledToSize(self.size.scaledByFactor(factor))
    }
    
    func _scaledToSize(_ size: CGSize) -> UIImage {
        if size == self.size {
            return self
        }
        
        let isOpaque: Bool = self.cgImage!.alphaInfo == .none
        let renderingMode: RenderingMode = self.renderingMode
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!.withRenderingMode(renderingMode)
        UIGraphicsEndImageContext()
        return result
    }
}
