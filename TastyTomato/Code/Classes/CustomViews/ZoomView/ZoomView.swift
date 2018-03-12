//
//  ZoomView.swift
//  TastyTomato
//
//  Created by Jan Nash on 11/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: - ZoomViewDelegate
public protocol ZoomViewDelegate: class {
    func zoomed(to scale: CGFloat, in zoomView: ZoomView)
}


// MARK: - ZoomView
// MARK: Interface
extension ZoomView {
    // ReadOnly
    public var contentView: UIView? {
        return self._contentView
    }
    
    // ReadWrite
    public var delegate: ZoomViewDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    public var isScrollEnabled: Bool {
        get {
            return self._scrollView.isScrollEnabled
        }
        set {
            self._scrollView.isScrollEnabled = newValue
        }
    }
    
    public var zoomThreshold: CGFloat {
        get {
            return self._zoomThreshold
        }
        set(newZoomThreshold) {
            self._zoomThreshold = newZoomThreshold
        }
    }
    
    public var maximumScale: CGFloat {
        get {
            return self._maximumZoomScale
        }
        set(newMaximumZoomScale) {
            self._maximumZoomScale = newMaximumZoomScale
        }
    }
    
    public var showsHorizontalScrollIndicator: Bool {
        get {
            return self._scrollView.showsHorizontalScrollIndicator
        }
        set(newShowsHorizontalScrollIndicator) {
            self._scrollView.showsHorizontalScrollIndicator = newShowsHorizontalScrollIndicator
        }
    }
    
    public var showsVerticalScrollIndicator: Bool {
        get {
            return self._scrollView.showsVerticalScrollIndicator
        }
        set(newShowsVerticalScrollIndicator) {
            self._scrollView.showsVerticalScrollIndicator = newShowsVerticalScrollIndicator
        }
    }
    
    public var decelerationRate: CGFloat {
        get {
            return self._scrollView.decelerationRate
        }
        set(newDecelerationRate) {
            self._scrollView.decelerationRate = newDecelerationRate
        }
    }
    
    public var bounces: Bool {
        get {
            return self._scrollView.bounces
        }
        set(newBounces) {
            self._scrollView.bounces = newBounces
        }
    }
    
    public var bouncesZoom: Bool {
        get {
            return self._scrollView.bouncesZoom
        }
        set(newBouncesZoom) {
            self._scrollView.bouncesZoom = newBouncesZoom
        }
    }
    
    public var doubleTapEnabled: Bool {
        get {
            return self._doubleTapEnabled
        }
        set(newDoubleTapEnabled) {
            self._doubleTapEnabled = newDoubleTapEnabled
        }
    }
    
    public var zoomOutTapEnabled: Bool {
        get {
            return self._zoomOutTapEnabled
        }
        set(newZoomOutTapEnabled) {
            self._zoomOutTapEnabled = newZoomOutTapEnabled
        }
    }
    
    public var centerHorizontally: Bool {
        get {
            return self._centerHorizontally
        }
        set(newCenterHorizontally) {
            self._centerHorizontally = newCenterHorizontally
        }
    }
    
    public var centerVertically: Bool {
        get {
            return self._centerVertically
        }
        set(newCenterVertically) {
            self._centerVertically = newCenterVertically
        }
    }
    
    // Functions
    public func zoomOut(animated: Bool = true) {
        self._zoomOut(animated: animated)
    }
    
    // Call this when you changed the size of the
    // contentView to ensure that the minimum and 
    // maximum zoomScale as well as the scrollView-
    // contentSize are updated accordingly
    public func contentViewSizeChanged() {
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
        self._updateTapRecognizers()
    }
    
    // Private Weak Variables
    fileprivate weak var _delegate: ZoomViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _scrollView: ZoomToPointScrollView = self._createScrollView()
    
    // Private Variables
    fileprivate var _contentView: UIView
    
    fileprivate var __doubleTapRecognizer: UITapGestureRecognizer?
    fileprivate var __zoomOutTapRecognizer: UITapGestureRecognizer?
    
    fileprivate var _zoomThreshold: CGFloat = 0.2
    fileprivate var __doubleTapEnabled: Bool = true
    fileprivate var __zoomOutTapEnabled: Bool = true
    fileprivate var _centerHorizontally: Bool = true
    fileprivate var _centerVertically: Bool = true
    fileprivate var __maximumZoomScale: CGFloat = 1
    fileprivate var _doubleTapNextScale: CGFloat?

    
    // MARK: Frame / Size Overrides
    override public var frame: CGRect {
        get {
            return self._frame
        }
        set(newFrame) {
            self._frame = newFrame
        }
    }
    
    override public var size: CGSize {
        get {
            return self._size
        }
        set(newSize) {
            self._size = newSize
        }
    }
    
    override public var width: CGFloat {
        get {
            return self._width
        }
        set(newWidth) {
            self._width = newWidth
        }
    }
    
    override public var height: CGFloat {
        get {
            return self._height
        }
        set(newHeight) {
            self._height = newHeight
        }
    }
}


// MARK: Delegate / DataSource
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
}


// MARK: Computed Variables
private extension ZoomView {
    var _maximumZoomScale: CGFloat {
        get {
            return self._scrollView.maximumZoomScale
        }
        set(newMaximumZoomScale) {
            let scrollView: UIScrollView = self._scrollView
            scrollView.maximumZoomScale = newMaximumZoomScale
            if scrollView.zoomScale > newMaximumZoomScale {
                scrollView.zoomIn(animated: false)
            }
        }
    }
    
    var _doubleTapEnabled: Bool {
        get {
            return self.__doubleTapEnabled
        }
        set(newDoubleTapEnabled) {
            self.__doubleTapEnabled = newDoubleTapEnabled
            self._updateDoubleTapRecognizer()
        }
    }
    
    var _zoomOutTapEnabled: Bool {
        get {
            return self.__zoomOutTapEnabled
        }
        set(newZoomOutTapEnabled) {
            self.__zoomOutTapEnabled = newZoomOutTapEnabled
            self._updateZoomOutTapRecognizer()
        }
    }
    
    var _doubleTapRecognizer: UITapGestureRecognizer {
        return self.__doubleTapRecognizer ?? {
            let doubleTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
            doubleTapRecognizer.numberOfTapsRequired = 2
            doubleTapRecognizer.addTarget(
                self,
                action: #selector(_handleDoubleTap(_:))
            )
            
            self.__doubleTapRecognizer = doubleTapRecognizer
            return doubleTapRecognizer
        }()
    }
    
    var _zoomOutTapRecognizer: UITapGestureRecognizer {
        return self.__zoomOutTapRecognizer ?? {
            let zoomOutRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
            zoomOutRecognizer.numberOfTapsRequired = 2
            zoomOutRecognizer.numberOfTouchesRequired = 2
            zoomOutRecognizer.addTarget(
                self,
                action: #selector(_handleZoomOutTap)
            )
            
            self.__zoomOutTapRecognizer = zoomOutRecognizer
            return zoomOutRecognizer
        }()
    }
}


// MARK: Frame / Size Override Implementations
private extension ZoomView {
    var _frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            super.frame = newFrame
            self._scrollView.size = newFrame.size
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
    
    var _size: CGSize {
        get {
            return super.size
        }
        set(newSize) {
            super.size = newSize
            self._scrollView.size = newSize
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
    
    var _width: CGFloat {
        get {
            return super.width
        }
        set(newWidth) {
            super.width = newWidth
            self._scrollView.width = newWidth
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
    
    var _height: CGFloat {
        get {
            return super.height
        }
        set(newHeight) {
            super.height = newHeight
            self._scrollView.height = newHeight
            self._updateZoomScalesAndAdjustScrollViewContentInsets()
        }
    }
}


// MARK: Did Zoom in ScrollView
private extension ZoomView {
    func _didZoom(in scrollView: UIScrollView) {
        self._adjustScrollViewContentInsets()
        self.delegate?.zoomed(to: scrollView.zoomScale, in: self)
    }
}


// MARK: Tap Recognizers
private extension ZoomView {
    func _updateTapRecognizers() {
        self._updateDoubleTapRecognizer()
        self._updateZoomOutTapRecognizer()
    }
    
    func _updateDoubleTapRecognizer() {
        guard (self.doubleTapEnabled == (self.__doubleTapRecognizer == nil)) else {
            return
        }
        
        if self.doubleTapEnabled {
            self._scrollView.addGestureRecognizer(self._doubleTapRecognizer)
        } else {
            self._scrollView.removeGestureRecognizer(self._doubleTapRecognizer)
            self.__doubleTapRecognizer = nil
        }
    }
    
    func _updateZoomOutTapRecognizer() {
        guard (self.zoomOutTapEnabled == (self.__zoomOutTapRecognizer == nil)) else {
            return
        }
        
        if self.zoomOutTapEnabled {
            self._scrollView.addGestureRecognizer(self._zoomOutTapRecognizer)
        } else {
            self._scrollView.removeGestureRecognizer(self._zoomOutTapRecognizer)
            self.__zoomOutTapRecognizer = nil
        }
    }
}


// MARK: Tap Handling
private extension ZoomView {
    @objc func _handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        let scrollView: ZoomToPointScrollView = self._scrollView
        
        let minScale: CGFloat = scrollView.minimumZoomScale
        let maxScale: CGFloat = scrollView.maximumZoomScale
        guard abs(minScale - maxScale) > self.zoomThreshold else {
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


// MARK: Zoom Out And Update Content Position
private extension ZoomView {
    func _zoomOut(animated: Bool) {
        let animationDuration: TimeInterval = animated ? 0.2 : 0
        
        UIView.animate(withDuration: animationDuration) {
            self._scrollView.zoomScale = self._scrollView.minimumZoomScale
            self._adjustScrollViewContentInsets()
        }
    }
}


// MARK: ContentView Size Change Handling
private extension ZoomView {
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
        let centerH: Bool = self.centerHorizontally
        let centerV: Bool = self.centerVertically
        
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
            self.delegate?.zoomed(to: currentZoomScale, in: self)
        }
    }
}
