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
    
    public var zoomThreshold: CGFloat {
        get {
            return self._zoomThreshold
        }
        set(newZoomThreshold) {
            self._zoomThreshold = newZoomThreshold
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
    
    // Functions
    public func zoomOut(animated: Bool = true) {
        self._scrollView.zoomOut(animated: animated)
    }
    
    // Call these when you changed the size of the
    // contentView to ensure that the minimum and 
    // maximum zoomScale are updated accordingly
    public func updateZoomScales() {
        self._updateZoomScales()
    }
    
    public func updateContentPosition(animated: Bool = true) {
        self._updateContentPosition(animated: animated)
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
        self.init(frame: .zero, contentView: contentView)
    }
    
    // Designated Init
    public init(frame: CGRect, contentView: UIView) {
        self._contentView = contentView
        super.init(frame: frame)
        self._addSubviews()
        self._updateTapRecognizers()
    }
    
    // Private Weak Variable Properties
    fileprivate weak var _delegate: ZoomViewDelegate?
    
    // Private Lazy Variable Properties
    // Non-nillable
    fileprivate lazy var _scrollView: UIScrollView = self._createScrollView()
    // Nillable
    fileprivate lazy var _doubleTapRecognizer: UITapGestureRecognizer! = self._createDoubleTapRecognizer()
    fileprivate lazy var _zoomOutTapRecognizer: UITapGestureRecognizer! = self._createZoomOutRecognizer()
    
    // Private Variable Properties
    fileprivate var _contentView: UIView
    fileprivate var _zoomThreshold: CGFloat = 1
    fileprivate var __doubleTapEnabled: Bool = true
    fileprivate var __zoomOutTapEnabled: Bool = true
}


// MARK: Layout Overrides
extension ZoomView {
    override public var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            super.frame = newFrame
            self._scrollView.size = newFrame.size
        }
    }
    
    override public var size: CGSize {
        get {
            return super.size
        }
        set(newSize) {
            super.size = newSize
            self._scrollView.size = newSize
        }
    }
    
    override public var width: CGFloat {
        get {
            return super.width
        }
        set(newWidth) {
            super.width = newWidth
            self._scrollView.width = newWidth
        }
    }
    
    override public var height: CGFloat {
        get {
            return super.height
        }
        set(newHeight) {
            super.height = newHeight
            self._scrollView.height = newHeight
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
        self._updateContentPosition(animated: true)
        self.delegate?.zoomed(to: scrollView.zoomScale, in: self)
    }
}


// MARK: // Private
// MARK: Lazy Property Creation
private extension ZoomView {
    func _createScrollView() -> UIScrollView {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.clipsToBounds = false
        scrollView.delegate = self
        scrollView.addSubview(self._contentView)
        return scrollView
    }
    
    func _createDoubleTapRecognizer() -> UITapGestureRecognizer {
        let doubleTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.addTarget(
            self,
            action: #selector(_handleDoubleTap(_:))
        )
        
        return doubleTapRecognizer
    }
    
    func _createZoomOutRecognizer() -> UITapGestureRecognizer {
        let zoomOutRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        zoomOutRecognizer.numberOfTapsRequired = 2
        zoomOutRecognizer.numberOfTouchesRequired = 2
        zoomOutRecognizer.addTarget(
            self,
            action: #selector(_handleZoomOutTap)
        )
        
        return zoomOutRecognizer
    }
}


// MARK: Computed Properties
private extension ZoomView {
    var _doubleTapEnabled: Bool {
        get {
            return self.__doubleTapEnabled
        }
        set(newDoubleTapEnabled) {
            guard newDoubleTapEnabled != self.__doubleTapEnabled else {
                return
            }
            self.__doubleTapEnabled = newDoubleTapEnabled
            self._updateDoubleTapRecognizer()
        }
    }
    
    var _zoomOutTapEnabled: Bool {
        get {
            return self.__zoomOutTapEnabled
        }
        set(newZoomOutTapEnabled) {
            guard newZoomOutTapEnabled != self._zoomOutTapEnabled else {
                return
            }
            self.__zoomOutTapEnabled = newZoomOutTapEnabled
            self._updateZoomOutTapRecognizer()
        }
    }
}


// MARK: Add Subviews
private extension ZoomView {
    func _addSubviews() {
        self.addSubview(self._scrollView)
    }
}


// MARK: Tap Recognizers
private extension ZoomView {
    func _updateTapRecognizers() {
        self._updateDoubleTapRecognizer()
        self._updateZoomOutTapRecognizer()
    }
    
    func _updateDoubleTapRecognizer() {
        if self.doubleTapEnabled {
            self._scrollView.addGestureRecognizer(self._doubleTapRecognizer)
        } else {
            self._scrollView.removeGestureRecognizer(self._doubleTapRecognizer)
            self._doubleTapRecognizer = nil
        }
    }
    
    func _updateZoomOutTapRecognizer() {
        if self.zoomOutTapEnabled {
            self._scrollView.addGestureRecognizer(self._zoomOutTapRecognizer)
        } else {
            self._scrollView.removeGestureRecognizer(self._zoomOutTapRecognizer)
            self._zoomOutTapRecognizer = nil
        }
    }
}


// MARK: Tap Handling
private extension ZoomView {
    @objc func _handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        let scrollView: UIScrollView = self._scrollView
        
        let minScale: CGFloat = scrollView.minimumZoomScale
        let maxScale: CGFloat = scrollView.maximumZoomScale
        guard minScale != maxScale else {
            return
        }
        
        let midScale: CGFloat = (maxScale + minScale) / 2
        let currentScale: CGFloat = scrollView.zoomScale
        
        struct Helper {
            static var nextScale: CGFloat!
        }
        
        var newScale: CGFloat = minScale
        switch currentScale {
        case let scale where scale < midScale:
            newScale = midScale
            Helper.nextScale = maxScale
        case let scale where scale == maxScale:
            newScale = midScale
            Helper.nextScale = minScale
        case let scale where scale == midScale:
            newScale = Helper.nextScale ?? minScale
        case let scale where scale < maxScale:
            newScale = maxScale
        default:
            newScale = minScale
        }
        
        let point: CGPoint = recognizer.location(ofTouch: 0, in: scrollView)
        scrollView.zoom(to: point, with: newScale)
    }
    
    @objc func _handleZoomOutTap() {
        self._scrollView.zoomOut()
    }
}


// MARK: Update Content Position
private extension ZoomView {
    func _updateContentPosition(animated: Bool) {
        let scrollView: UIScrollView = self._scrollView
        let contentView: UIView = self._contentView
        
        let horizontalAnimation: () -> Void =
            (contentView.width < scrollView.width) ?
                contentView.centerHInSuperview :
                { contentView.left = 0 }
        
        let verticalAnimation: () -> Void =
            (contentView.height < scrollView.height) ?
                contentView.centerVInSuperview :
                { contentView.top = 0 }
        
        let animationDuration: TimeInterval = animated ? 0.2 : 0
        
        UIView.animate(withDuration: animationDuration) {
            horizontalAnimation()
            verticalAnimation()
        }
    }
}


// MARK: Update Zoom Scales
private extension ZoomView {
    func _updateZoomScales() {
        let contentView: UIView = self._contentView
        let scrollView: UIScrollView = self._scrollView
        
        let widthRatio: CGFloat = scrollView.width / contentView.width
        let heightRatio: CGFloat = scrollView.height / contentView.height
        
        let currentZoomScale: CGFloat = scrollView.zoomScale
        let exactMinScale: CGFloat = min(widthRatio, heightRatio) * currentZoomScale
        
        let threshold: CGFloat = self._zoomThreshold
        let belowThreshold: Bool = exactMinScale < threshold
        
        let minScale: CGFloat = belowThreshold ? exactMinScale : threshold
        let maxScale: CGFloat = belowThreshold ? 1 : threshold
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
    }
}