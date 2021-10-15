//
//  TagsView.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/30/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: - TagsViewDelegate
public protocol TagsViewDelegate: AnyObject {
    func changedContentHeight(to height: CGFloat, in tagsView: TagsView)
}


// MARK: - TagsView
// MARK: Interface
public extension TagsView {
    var delegate: TagsViewDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    // Functions
    func rearrangeTagViews() {
        self._rearrangeTagViews(startIndex: 0, width: self.width, animated: false)
    }
    
    func addTagView(_ tagView: TagView) {
        self._addTagView(tagView)
    }
    
    func addTagViews(_ tagViews: [TagView]) {
        self._addTagViews(tagViews)
    }
    
    func removeTagView(_ tagView: TagView, animated: Bool = true) {
        self._removeTagView(tagView, animated: animated)
    }
    
    func removeAllTagViews() {
        self._removeAllTagViews()
    }
}


// MARK: Class Declaration
public class TagsView: UIView {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        fatalError("TagsView does not support NSCoding")
    }
    
    // Override Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self._addSubviews()
    }
    
    // Private Static Constants
    fileprivate static let _interItemSpacing: CGFloat = 8
    fileprivate static let _gradientHeight: CGFloat = 4
    fileprivate static let _gradientInnerColor: CGColor = UIColor.clear.cgColor
    fileprivate static let _gradientOuterColor: CGColor = UIColor.gray555555.withAlpha(0.1).cgColor
    fileprivate static let _rowHeightWithSpacing: CGFloat = TagView.defaultHeight + TagsView._interItemSpacing
    
    // Private Weak Variables
    fileprivate weak var _delegate: TagsViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _scrollView: UIScrollView = self._createScrollView()
    fileprivate lazy var _topGradientLayer: CAGradientLayer = self._createTopGradientLayer()
    fileprivate lazy var _bottomGradientLayer: CAGradientLayer = self._createBottomGradientLayer()
    
    // Private Variables
    fileprivate var _tagViews: [TagView] = []
    
    
    // Layout Overrides
    public override func layoutSubviews() {
        self._layoutSubviews()
    }
    
    // Frame Override
    public override var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            super.frame = newFrame
            self._updateGradientLayerHiddenStates(
                withContentOffset: self._scrollView.contentOffset.y
            )
        }
    }
}


// MARK: Delegates / DataSources
// MARK: UIScrollViewDelegate
extension TagsView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self._updateGradientLayerHiddenStates(withContentOffset: scrollView.contentOffset.y)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension TagsView {
    func _createScrollView() -> UIScrollView {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }
    
    func _createTopGradientLayer() -> CAGradientLayer {
        return self._createGradientLayer(
            [TagsView._gradientOuterColor, TagsView._gradientInnerColor]
        )
    }
    
    func _createBottomGradientLayer() -> CAGradientLayer {
        return self._createGradientLayer(
            [TagsView._gradientInnerColor, TagsView._gradientOuterColor]
        )
    }
    
    // Private Helpers
    private func _createGradientLayer(_ colors: [CGColor]) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame.size.height = TagsView._gradientHeight
        gradient.colors = colors
        return gradient
    }
}


// MARK: Layout Override Implementations
private extension TagsView {
    func _layoutSubviews() {
        let size: CGSize = self.size
        let width: CGFloat = size.width
        
        let scrollView: UIScrollView = self._scrollView
        scrollView.size = size
        
        if width != scrollView.contentSize.width {
            self._rearrangeTagViews(startIndex: 1, width: width, animated: true)
            scrollView.contentSize.width = width
        }
        
        self._topGradientLayer.frame.size.width = width
    
        let bottomGradient: CAGradientLayer = self._bottomGradientLayer
        bottomGradient.frame.bottom = self.height
        bottomGradient.frame.size.width = width
    }
    
    // Private Helper
    func _rearrangeTagViews(startIndex: Int, width: CGFloat, animated: Bool) {
        let tagViews: [TagView] = self._tagViews
        
        if tagViews.isEmpty {
            self._setScrollViewContentHeight(to: 0)
            return
        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        let spacing: CGFloat = TagsView._interItemSpacing
        let rowHeight: CGFloat = TagsView._rowHeightWithSpacing
        
        if let leftNeighbour: TagView = tagViews[safe: startIndex - 1] {
            x = leftNeighbour.right + spacing
            y = leftNeighbour.top
        }
        
        let getOrigin: ((TagView) -> CGPoint) = {
            let tagViewWidth: CGFloat = $0.width
            if (x > 0) && (x + tagViewWidth > width) {
                x = 0
                y += rowHeight
            }
            let origin: CGPoint = CGPoint(x: x, y: y)
            x += tagViewWidth + spacing
            return origin
        }
        
        let tagViewsToUpdate = tagViews.suffix(from: startIndex)
        let origins: [CGPoint] = tagViewsToUpdate.map(getOrigin)
        
        let newContentHeight: CGFloat = (origins.last?.y ?? 0) + TagView.defaultHeight
        self._setScrollViewContentHeight(to: newContentHeight)
        
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            zip(tagViewsToUpdate, origins).forEach({ $0.0.origin = $0.1 })
        }
    }
    
    // Helpers
    func _setScrollViewContentHeight(to height: CGFloat) {
        let scrollView: UIScrollView = self._scrollView
        scrollView.contentSize.height = height
        self._updateGradientLayerHiddenStates(withContentOffset: scrollView.contentOffset.y)
        self.delegate?.changedContentHeight(to: height, in: self)
    }
}


// MARK: Delegate / DataSource Implementations
// MARK: Add Subviews
private extension TagsView {
    func _addSubviews() {
        self.addSubview(self._scrollView)
        let layer: CALayer = self.layer
        layer.addSublayer(self._topGradientLayer)
        layer.addSublayer(self._bottomGradientLayer)
    }
}


// MARK: Update Hidden States of GradientLayers
private extension TagsView {
    func _updateGradientLayerHiddenStates(withContentOffset contentOffset: CGFloat) {
        let scrollView: UIScrollView = self._scrollView
        if scrollView.contentSize.height <= self.height {
            self._topGradientLayer.isHidden = true
            self._bottomGradientLayer.isHidden = true
        } else {
            self._topGradientLayer.isHidden = scrollView.willBeScrolledToTop(withVerticalContentOffset: contentOffset)
            self._bottomGradientLayer.isHidden = scrollView.willBeScrolledToBottom(withVerticalContentOffset: contentOffset)
        }
    }
}


// MARK: Add / Remove TagViews
private extension TagsView {
    func _addTagView(_ tagView: TagView) {
        let index: Int = self._tagViews.count
        self._tagViews.append(tagView)
        self._rearrangeTagViews(startIndex: index, width: self.width, animated: false)
        self._scrollView.addSubview(tagView)
    }
    
    func _addTagViews(_ tagViews: [TagView]) {
        let scrollView: UIScrollView = self._scrollView
        tagViews.forEach(scrollView.addSubview)
        let index: Int = self._tagViews.count
        self._tagViews += tagViews
        self._rearrangeTagViews(startIndex: index, width: self.width, animated: false)
    }
    
    func _removeTagView(_ tagView: TagView, animated: Bool) {
        guard let index: Int = self._tagViews.firstIndex(of: tagView) else { return }
        tagView.removeFromSuperview()
        self._tagViews.remove(at: index)
        self._rearrangeTagViews(startIndex: index, width: self.width, animated: animated)
    }
    
    func _removeAllTagViews() {
        self._tagViews.forEach({ $0.removeFromSuperview() })
        self._tagViews = []
        self._scrollView.contentSize = CGSize(width: self.width, height: 0)
    }
}
