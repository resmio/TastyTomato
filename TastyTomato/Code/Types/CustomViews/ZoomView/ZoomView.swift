//
//  ZoomView.swift
//  TastyTomato
//
//  Created by Jan Nash on 11/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation
import SignificantSpices


// MARK: // Public
// MARK: -
public protocol ZoomViewDelegate: class {
    func zoomed(to scale: CGFloat, in zoomView: ZoomView)
}


// MARK: -
// MARK: Interface
public extension ZoomView {
    // Setters
    func setDelegate(_ delegate: ZoomViewDelegate?) {
        self._delegate = delegate
    }
    
    func setScrollEnabled(_ enabled: Bool) {
        self._scrollView.isScrollEnabled = enabled
    }
    
    func setZoomThreshold(_ threshold: CGFloat) {
        self._zoomThreshold = threshold
    }
    
    func setMaximumScale(_ scale: CGFloat) {
        self._setMaximumZoomScale(scale)
    }
    
    func setShowsHorizontalScrollIndicator(_ shows: Bool) {
        self._scrollView.showsHorizontalScrollIndicator = shows
    }
    
    func setShowsVerticalScrollIndicator(_ shows: Bool) {
        self._scrollView.showsVerticalScrollIndicator = shows
    }
    
    func setDecelerationRate(_ rate: UIScrollView.DecelerationRate) {
        self._scrollView.decelerationRate = rate
    }
    
    func setBounces(_ bounces: Bool) {
        self._scrollView.bounces = bounces
    }
    
    func setBouncesZoom(_ bounces: Bool) {
        self._scrollView.bouncesZoom = bounces
    }
    
    func setDoubleTapEnabled(_ enabled: Bool) {
        self._setDoubleTapEnabled(enabled)
    }
    
    func setZoomOutTapEnabled(_ enabled: Bool) {
        self._setZoomOutTapEnabled(enabled)
    }
    
    func setCenterHorizontally(_ center: Bool) {
        self._setCenterHorizontally(center)
    }
    
    func setCenterVertically(_ center: Bool) {
        self._setCenterVertically(center)
    }
    
    func setContentInset(_ inset: UIEdgeInsets) {
        self._scrollView.contentInset = inset
    }
    
    // Functions
    func zoomOut(animated: Bool = true) {
        self._zoomOut(animated: animated)
    }
    
    // Call this when you changed the size of the
    // contentView to ensure that the minimum and 
    // maximum zoomScale as well as the scrollView-
    // contentSize are updated accordingly
    func contentViewSizeChanged() {
        self._contentViewSizeChanged()
    }
}


// MARK: Class Declaration
public class ZoomView: UIView {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("ZoomView does not support NSCoding")
    }
    
    // Privatized Inits
    private init() { fatalError() }
    private override init(frame: CGRect) { fatalError() }
    
    // Convenience Init
    public convenience init(contentView: UIView) {
        self.init(frame: contentView.bounds, contentView: contentView)
    }
    
    // Designated Init
    fileprivate init(frame: CGRect, contentView: UIView) {
        self._contentView = contentView
        super.init(frame: frame)
        self.addSubview(self._scrollView)
        self.setDoubleTapEnabled(true)
        self.setZoomOutTapEnabled(true)
    }
    
    // Private Weak Variables
    private weak var _delegate: ZoomViewDelegate?
    
    // Private Lazy Variables
    private lazy var _scrollView: ZoomToPointScrollView = self._createScrollView()
    
    // ALOs
    private lazy var _doubleTapRecognizer: ALO<UITapGestureRecognizer> = ALO(self._createDoubleTapRecognizer)
    private lazy var _zoomOutTapRecognizer: ALO<UITapGestureRecognizer> = ALO(self._createZoomOutTapRecognizer)
    
    // Private Variables
    private var _contentView: UIView
    private var _zoomThreshold: CGFloat = 0.2
    private var _centerHorizontally: Bool = true
    private var _centerVertically: Bool = true
    private var __maximumZoomScale: CGFloat = 1
    private var _doubleTapNextScale: CGFloat?

    // Frame / Size Overrides
    override public var frame: CGRect {
        get { return self._frame }
        set { self._frame = newValue }
    }
    
    override public var size: CGSize {
        get { return self._size }
        set { self._size = newValue }
    }
    
    override public var width: CGFloat {
        get { return self._width }
        set { self._width = newValue }
    }
    
    override public var height: CGFloat {
        get { return self._height }
        set { self._height = newValue }
    }
}


// MARK: Protocol Conformances
// MARK: UIScrollViewDelegate
extension ZoomView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self._contentView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self._didZoom(in: scrollView)
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self._didZoom(in: scrollView)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension ZoomView {
    func _createScrollView() -> ZoomToPointScrollView {
        let contentView: UIView = self._contentView
        let scrollView: ZoomToPointScrollView = ZoomToPointScrollView(frame: self.bounds)
        scrollView.clipsToBounds = false
        scrollView.delegate = self
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView.size
        return scrollView
    }
    
    func _createDoubleTapRecognizer() -> UITapGestureRecognizer {
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        recognizer.numberOfTapsRequired = 2
        recognizer.addTarget(self, action: #selector(self._handleDoubleTap))
        return recognizer
    }
    
    func _createZoomOutTapRecognizer() -> UITapGestureRecognizer {
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        recognizer.numberOfTapsRequired = 2
        recognizer.numberOfTouchesRequired = 2
        recognizer.addTarget(self, action: #selector(self._handleZoomOutTap))
        return recognizer
    }
}


// MARK: Setter Implementations
private extension ZoomView {
    func _setMaximumZoomScale(_ scale: CGFloat) {
        let scrollView: UIScrollView = self._scrollView
        scrollView.maximumZoomScale = scale
        if scrollView.zoomScale > scale {
            scrollView.zoomIn(animated: false)
        }
    }
    
    func _setDoubleTapEnabled(_ enabled: Bool) {
        guard enabled == (self._doubleTapRecognizer¿ == nil) else { return }
        if enabled {
            self._scrollView.addGestureRecognizer(self._doubleTapRecognizer¡)
        } else {
            guard let recognizer: UITapGestureRecognizer = self._doubleTapRecognizer¿ else { return }
            self._scrollView.removeGestureRecognizer(recognizer)
            self._doubleTapRecognizer.clear()
        }
    }
    
    func _setZoomOutTapEnabled(_ enabled: Bool) {
        guard enabled == (self._zoomOutTapRecognizer¿ == nil) else { return }
        if enabled {
            self._scrollView.addGestureRecognizer(self._zoomOutTapRecognizer¡)
        } else {
            guard let recognizer: UITapGestureRecognizer = self._zoomOutTapRecognizer¿ else { return }
            self._scrollView.removeGestureRecognizer(recognizer)
            self._zoomOutTapRecognizer.clear()
        }
    }
    
    func _setCenterHorizontally(_ center: Bool) {
        self._centerHorizontally = center
        self._adjustScrollViewContentInsets()
    }
    
    func _setCenterVertically(_ center: Bool) {
        self._centerVertically = center
        self._adjustScrollViewContentInsets()
    }
}


// MARK: Frame / Size Override Implementations
private extension ZoomView {
    var _frame: CGRect {
        get { return super.frame }
        set(newFrame) {
            super.frame = newFrame
            self._scrollView.size = newFrame.size
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
    
    var _size: CGSize {
        get { return super.size }
        set(newSize) {
            super.size = newSize
            self._scrollView.size = newSize
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
    
    var _width: CGFloat {
        get { return super.width }
        set(newWidth) {
            super.width = newWidth
            self._scrollView.width = newWidth
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
    
    var _height: CGFloat {
        get { return super.height }
        set(newHeight) {
            super.height = newHeight
            self._scrollView.height = newHeight
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
}


// MARK: Protocol Conformance Implementations
// MARK: UIScrollViewDelegate
private extension ZoomView/*: UIScrollViewDelegate*/ {
    func _didZoom(in scrollView: UIScrollView) {
        self._adjustScrollViewContentInsets()
        self._delegate?.zoomed(to: scrollView.zoomScale, in: self)
    }
}


// MARK: Target Selectors
private extension ZoomView {
    @objc func _handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        let scrollView: ZoomToPointScrollView = self._scrollView
        
        let minScale: CGFloat = scrollView.minimumZoomScale
        let maxScale: CGFloat = scrollView.maximumZoomScale
        guard abs(minScale - maxScale) > self._zoomThreshold else {
            return
        }
        
        let midScale: CGFloat = (maxScale + minScale) / 2
        let currentScale: CGFloat = scrollView.zoomScale
        
        var newScale: CGFloat = minScale
        switch currentScale {
        case let scale where abs(scale - midScale) < 0.01:
            newScale = self._doubleTapNextScale ?? minScale
        case let scale where abs(scale - maxScale) < 0.01:
            newScale = midScale
            self._doubleTapNextScale = minScale
        case let scale where scale < midScale - 0.01:
            newScale = midScale
            self._doubleTapNextScale = maxScale
        case let scale where scale < maxScale - 0.01:
            newScale = maxScale
        default:
            newScale = minScale
        }
        
        let point: CGPoint = recognizer.location(ofTouch: 0, in: scrollView)
        scrollView.zoom(to: point, with: newScale)
    }
    
    @objc func _handleZoomOutTap() {
        self._zoomOut(animated: true)
    }
}


// MARK: Interface Implementations
private extension ZoomView {
    func _zoomOut(animated: Bool) {
        let animationDuration: TimeInterval = animated ? 0.2 : 0
        
        UIView.animate(withDuration: animationDuration) {
            self._scrollView.zoomScale = self._scrollView.minimumZoomScale
            self._adjustScrollViewContentInsets()
        }
    }
    
    func _contentViewSizeChanged() {
        let scrollView: UIScrollView = self._scrollView
        let contentViewSize: CGSize = self._contentView.size
        
        guard scrollView.contentSize != contentViewSize else {
            return
        }
        
        scrollView.contentSize = contentViewSize
        self._updateZoomScalesAndAdjustScrollViewContentInsets()
    }
}


// MARK: Adjust Content Position / Update Zoom Scales
private extension ZoomView {
    func _updateZoomScalesAndAdjustScrollViewContentInsets() {
        self._updateZoomScales()
        self._adjustScrollViewContentInsets()
    }
    
    func _adjustScrollViewContentInsets() {
        let centerH: Bool = self._centerHorizontally
        let centerV: Bool = self._centerVertically
        
        guard centerH || centerV else {
            return
        }
        
        let scrollView: UIScrollView = self._scrollView
        let boundsSize: CGSize = scrollView.bounds.size
        let contentSize: CGSize = scrollView.contentSize
        
        if centerH {
            let leftInset: CGFloat = (boundsSize.width - contentSize.width) / 2
            scrollView.contentInset.left = max(0, leftInset)
        }
        
        if centerV {
            let topInset: CGFloat = (boundsSize.height - contentSize.height) / 2
            scrollView.contentInset.top = max(0, topInset)
        }
    }

    func _updateZoomScales() {
        let scrollView: UIScrollView = self._scrollView
        let contentSize: CGSize = self._scrollView.contentSize
        
        let widthRatio: CGFloat = scrollView.width / contentSize.width
        let heightRatio: CGFloat = scrollView.height / contentSize.height
        
        let currentZoomScale: CGFloat = scrollView.zoomScale
        let minScale: CGFloat = min(widthRatio, heightRatio) * currentZoomScale
        
        scrollView.minimumZoomScale = minScale
        
        if currentZoomScale < minScale {
            self._scrollView.zoomOut(animated: false)
        } else {
            self._delegate?.zoomed(to: currentZoomScale, in: self)
        }
    }
}
