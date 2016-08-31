//
//  TagsView.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/30/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit



// MARK: // Public
// MARK: Interface
public extension TagsView {
    public func addTagView(tagView: TagView) {
        self._addTagView(tagView)
    }
    
    public func addTagViews(tagViews: [TagView]) {
        self._addTagViews(tagViews)
    }
    
    public func removeTagView(tagView: TagView) {
        self._removeTagView(tagView)
    }
    
    public func removeAllTagViews() {
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
        self._setupScrollView()
        self._setupGradientLayer()
    }
    
    // Private Constant Stored Properties
    private let _interItemSpacing: CGFloat = 8
    private let _gradientHeight: CGFloat = 20
    
    // Private Variable Stored Properties
    private var _scrollView: UIScrollView!
    private var _gradientLayer: CAGradientLayer!
    
    private var _tagViews: [TagView] = []
}


// MARK: Layout Subviews Override
extension TagsView {
    public override func layoutSubviews() {
        self._scrollView.size = self.size
        self._rearrangeTagViewsStartingFromIndex(0, animated: false)
        self._updateScrollViewContentHeight()
        self._updateGradientLayerFrame()
    }
}


// MARK: // Private
// MARK: Setup ScrollView
private extension TagsView {
    private func _setupScrollView() {
        let scrollView: UIScrollView = UIScrollView(size: self.size)
        scrollView.contentSize = self.size
        self._scrollView = scrollView
        self.addSubview(scrollView)
    }
    
    private func _setupGradientLayer() {
        let white: UIColor = UIColor.whiteColor()
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame.size.height = self._gradientHeight
        gradient.colors = [white.withAlpha(0).CGColor, white.CGColor]
        self._gradientLayer = gradient
        self.layer.addSublayer(gradient)
        
        self._updateGradientLayerFrame()
    }
    
    private func _updateGradientLayerFrame() {
        self._gradientLayer.frame.bottom = self.height
        self._gradientLayer.frame.size.width = self.width
    }
}


// MARK: Layout Helpers
private extension TagsView {
    private func _originForTagView(tagView: TagView) -> CGPoint {
        let index: Int = self._tagViews.indexOf(tagView)!
        
        if index == 0 {
            return CGPointZero
        } else {
            let rightBorder: CGFloat = self.width
            let leftNeighbour: TagView = self._tagViews[index - 1]
            let supposedLeft: CGFloat = (
                leftNeighbour.right +
                self._interItemSpacing
            )
            
            if supposedLeft + tagView.width <= rightBorder {
                return CGPoint(x: supposedLeft, y: leftNeighbour.top)
            } else {
                let y: CGFloat = leftNeighbour.bottom + self._interItemSpacing
                return CGPoint(x: 0, y: y)
            }
        }
    }
    
    private func _rearrangeTagViewsStartingFromIndex(index: Int, animated: Bool) {
        let tagViews: [TagView] = Array(self._tagViews.suffixFrom(index))
        for tagView in tagViews {
            let newOrigin: CGPoint = self._originForTagView(tagView)
            if newOrigin == tagView.origin {
                continue
            }
            
            // TODO: Not sure if I like the animation... Let's see what Fabi says.
            UIView.animateWithDuration(animated ? 0.3 : 0) {
                tagView.origin = newOrigin
            }
        }
    }
    
    private func _updateScrollViewContentHeight() {
        if let lastTagView: TagView = self._tagViews.last {
            let height: CGFloat = max(lastTagView.bottom, self.height)
            self._scrollView.contentSize.height = height + self._gradientHeight
        }
    }
}


// MARK: Add / Remove TagViews
private extension TagsView {
    private func _addTagView(tagView: TagView) {
        self._addTagViews([tagView])
    }
    
    private func _addTagViews(tagViews: [TagView]) {
        self._tagViews += tagViews
        
        for tagView in tagViews {
            let origin: CGPoint = self._originForTagView(tagView)
            tagView.origin = origin
            self._scrollView.addSubview(tagView)
        }
        
        self._updateScrollViewContentHeight()
    }
    
    private func _removeTagView(tagView: TagView) {
        tagView.removeFromSuperview()
        let index: Int = self._tagViews.indexOf(tagView)!
        self._tagViews.removeAtIndex(index)
        self._rearrangeTagViewsStartingFromIndex(index, animated: true)
        
        self._updateScrollViewContentHeight()
    }
    
    private func _removeAllTagViews() {
        for tagView in self._tagViews {
            tagView.removeFromSuperview()
        }
        self._tagViews = []
        self._updateScrollViewContentHeight()
    }
}
