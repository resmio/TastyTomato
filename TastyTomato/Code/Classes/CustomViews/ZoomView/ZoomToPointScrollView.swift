//
//  ZoomToPointScrollView.swift
//  TastyTomato
//
//  Created by Jan Nash on 6/30/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Interface
extension ZoomToPointScrollView {
    func zoom(to zoomPoint: CGPoint, with scale: CGFloat, animated: Bool = true) {
        self._zoom(to: zoomPoint, with: scale, animated: animated)
    }
}


// MARK: Class Declaration
class ZoomToPointScrollView: UIScrollView {
    // MARK: ContentOffset Override
    // !!!: This is an intentional noop, since when the contentSize is smaller
    // than the bounds of the scrollView,self.zoom(to rect: CGRect, animated: Bool)
    // calls this method with the contentOffset doubled. Why? I don't know. Nooping
    // the method does actually work around that problem, still, it makes the method
    // unusable, that's why it's marked as unavailabe here.
    @available(*, unavailable)
    override func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        super.setContentOffset(CGPoint(x: contentOffset.x / 2, y: contentOffset.y / 2), animated: animated)
    }
}


// MARK: // Private
// MARK: ZoomToPoint implementation
private extension ZoomToPointScrollView {
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
        
        let zoomRectOrigin: CGPoint = CGPoint(
            x: normalizedZoomPoint.x - (zoomRectSize.width / 2),
            y: normalizedZoomPoint.y - (zoomRectSize.height / 2)
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
