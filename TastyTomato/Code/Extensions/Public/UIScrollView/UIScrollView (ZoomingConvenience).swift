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
    public func zoomOut(animated: Bool = true) {
        self._zoomOut(animated: animated)
    }
    
    public func zoomIn(animated: Bool = true) {
        self._zoomIn(animated: animated)
    }
    
    public func zoom(to zoomScale: CGFloat, animated: Bool = true) {
        self._zoom(to: zoomScale, animated: animated)
    }
    
    public func zoom(to zoomPoint: CGPoint, with scale: CGFloat, animated: Bool = true) {
        self._zoom(to: zoomPoint, with: scale, animated: animated)
    }
}


// MARK: // Internal
internal extension UIScrollView {
    func zoomOut_(animated: Bool = true) -> Bool {
        return self._zoomOut(animated: animated)
    }
    
    func zoomIn_(animated: Bool = true) -> Bool {
        return self._zoomIn(animated: animated)
    }
    
    func zoom_(to zoomScale: CGFloat, animated: Bool = true) -> Bool {
        return self._zoom(to: zoomScale, animated: animated)
    }
}


// MARK: // Private
private extension UIScrollView {
    @discardableResult func _zoomOut(animated: Bool) -> Bool {
        if self.zoomScale != self.minimumZoomScale {
            self.setZoomScale(self.minimumZoomScale, animated: animated)
            return true
        } else {
            return false
        }
    }
    
    @discardableResult func _zoomIn(animated: Bool) -> Bool {
        if self.zoomScale != self.maximumZoomScale {
            self.setZoomScale(self.maximumZoomScale, animated: animated)
            return true
        } else {
            return false
        }
    }
    
    @discardableResult func _zoom(to zoomScale: CGFloat, animated: Bool) -> Bool {
        if self.zoomScale == zoomScale {
            self.setZoomScale(zoomScale, animated: animated)
            return true
        } else {
            return false
        }
    }
    
    func _zoom(to zoomPoint: CGPoint, with scale: CGFloat, animated: Bool) {
        let clampedScale: CGFloat = min(self.maximumZoomScale, max(self.minimumZoomScale, scale))
        let normalizationFactor: CGFloat = (1 / self.zoomScale)
        
        let contentOffset: CGPoint = self.contentOffset
        let normalizedZoomPoint: CGPoint = CGPoint(
            x: (zoomPoint.x + contentOffset.x) * normalizationFactor,
            y: (zoomPoint.y + contentOffset.y) * normalizationFactor
        )
        
        let bounds: CGRect = self.bounds
        let zoomRectSize: CGSize = CGSize(
            width: bounds.width / scale,
            height: bounds.height / scale
        )
        
        
        let zoomRectMaxX: CGFloat = bounds.width - zoomRectSize.width
        let zoomRectMaxY: CGFloat = bounds.height - zoomRectSize.height
        let zoomRectPreferredX: CGFloat = normalizedZoomPoint.x - (zoomRectSize.width / 2)
        let zoomRectPreferredY: CGFloat = normalizedZoomPoint.y - (zoomRectSize.height / 2)
        
        
        let zoomRectOrigin: CGPoint = CGPoint(
            x: min(zoomRectMaxX, max(0, zoomRectPreferredX)),
            y: min(zoomRectMaxY, max(0, zoomRectPreferredY))
        )
        
        let zoomRect: CGRect = CGRect(
            origin: zoomRectOrigin,
            size: zoomRectSize
        )
        
        guard animated else {
            self.zoom(to: zoomRect, animated: false)
            return
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.6,
            options: [.allowUserInteraction],
            animations: {
                self.zoom(to: zoomRect, animated: false)
            },
            completion: { _ in
                guard let delegate: UIScrollViewDelegate = self.delegate else { return }
                guard let viewForZooming: UIView = delegate.viewForZooming?(in: self) else { return }
                delegate.scrollViewDidEndZooming?(self, with: viewForZooming, atScale: clampedScale)
            }
        )
    }
}
