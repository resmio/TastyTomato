//
//  UIScrollView (ZoomingConvenience).swift
//  TastyTomato
//
//  Created by Jan Nash on 11/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
extension UIScrollView {
    public func zoomToMinimum(animated: Bool = true) {
        self._zoomToMinimum(animated: animated)
    }
    
    public func zoomToMaximum(animated: Bool = true) {
        self._zoomToMaximum(animated: animated)
    }
    
    public func zoom(to zoomScale: CGFloat, animated: Bool = true) {
        self._zoom(to: zoomScale, animated: animated)
    }
    
    public func zoom(to zoomPoint: CGPoint, with scale: CGFloat, animated: Bool = true) {
        self._zoom(to: zoomPoint, with: scale, animated: animated)
    }
}


// MARK: // Private
private extension UIScrollView {
    func _zoomToMinimum(animated: Bool) {
        self.setZoomScale(self.minimumZoomScale, animated: animated)
    }
    
    func _zoomToMaximum(animated: Bool) {
        self.setZoomScale(self.maximumZoomScale, animated: animated)
    }
    
    func _zoom(to zoomScale: CGFloat, animated: Bool) {
        self.setZoomScale(zoomScale, animated: animated)
    }
    
    func _zoom(to zoomPoint: CGPoint, with scale: CGFloat, animated: Bool) {
        let normalizationFactor: CGFloat = (1 / self.zoomScale)
        let contentSize: CGSize = self.contentSize
        
        let normalizedContentSize: CGSize = contentSize.scaledByFactor(normalizationFactor)
        
        let boundsSize: CGSize = self.bounds.size
        
        let translatedZoomPointX: CGFloat = zoomPoint.x / (boundsSize.width * normalizedContentSize.width)
        let translatedZoomPointY: CGFloat = zoomPoint.y / (boundsSize.height * normalizedContentSize.height)
        
        let scaleFactor: CGFloat = 1 / scale
        let zoomRectSize: CGSize = boundsSize.scaledByFactor(scaleFactor)
        
        let zoomRectOrigin: CGPoint = CGPoint(
            x: translatedZoomPointX - (zoomRectSize.width / 2),
            y: translatedZoomPointY - (zoomRectSize.height / 2)
        )
        
        let zoomRect: CGRect = CGRect(
            origin: zoomRectOrigin,
            size: zoomRectSize
        )
        
        self.zoom(to: zoomRect, animated: animated)
    }
}
