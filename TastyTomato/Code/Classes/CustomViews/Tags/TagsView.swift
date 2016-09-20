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
    public func addTagView(_ tagView: TagView) {
        self._addTagView(tagView)
    }
    
    public func addTagViews(_ tagViews: [TagView]) {
        self._addTagViews(tagViews)
    }
    
    public func removeTagView(_ tagView: TagView, animated: Bool = true) {
        self._removeTagView(tagView, animated: animated)
    }
    
    public func removeAllTagViews() {
        self._removeAllTagViews()
    }
}


// MARK: Class Declaration
open class TagsView: UIView {
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
    fileprivate let _interItemSpacing: CGFloat = 8
    fileprivate let _gradientHeight: CGFloat = 20
    
    // Private Variable Stored Properties
    fileprivate var _scrollView: UIScrollView!
    fileprivate var _gradientLayer: CAGradientLayer!
    
    fileprivate var _tagViews: [TagView] = []
}


// MARK: Layout Subviews Override
extension TagsView {
    open override func layoutSubviews() {
        self._scrollView.size = self.size
        self._rearrangeTagViewsStartingFromIndex(0, animated: false)
        self._updateScrollViewContentHeight()
        self._updateGradientLayerFrame()
    }
}


// MARK: // Private
// MARK: Setup ScrollView
private extension TagsView {
    func _setupScrollView() {
        let scrollView: UIScrollView = UIScrollView(size: self.size)
        scrollView.contentSize = self.size
        self._scrollView = scrollView
        self.addSubview(scrollView)
    }
    
    func _setupGradientLayer() {
        let white: UIColor = UIColor.white
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame.size.height = self._gradientHeight
        gradient.colors = [white.withAlpha(0).cgColor, white.cgColor]
        self._gradientLayer = gradient
        self.layer.addSublayer(gradient)
        
        self._updateGradientLayerFrame()
    }
    
    func _updateGradientLayerFrame() {
        self._gradientLayer.frame.bottom = self.height
        self._gradientLayer.frame.size.width = self.width
    }
}


// MARK: Layout Helpers
private extension TagsView {
    func _originForTagView(_ tagView: TagView) -> CGPoint {
        let index: Int = self._tagViews.index(of: tagView)!
        
        if index == 0 {
            return CGPoint.zero
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
    
    func _rearrangeTagViewsStartingFromIndex(_ index: Int, animated: Bool) {
        let tagViews: [TagView] = Array(self._tagViews.suffix(from: index))
        for tagView in tagViews {
            let newOrigin: CGPoint = self._originForTagView(tagView)
            if newOrigin == tagView.origin {
                continue
            }
            
            // TODO: Not sure if I like the animation... Let's see what Fabi says.
            UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
                tagView.origin = newOrigin
            }) 
        }
    }
    
    func _updateScrollViewContentHeight() {
        if let lastTagView: TagView = self._tagViews.last {
            let lastTagViewBottom: CGFloat = lastTagView.bottom
            if lastTagViewBottom < self.height {
                self._scrollView.contentSize.height = self.height
            } else {
                self._scrollView.contentSize.height = lastTagViewBottom + self._gradientHeight
            }
        }
    }
}


// MARK: Add / Remove TagViews
private extension TagsView {
    func _addTagView(_ tagView: TagView) {
        self._tagViews.append(tagView)
        let origin: CGPoint = self._originForTagView(tagView)
        tagView.origin = origin
        self._scrollView.addSubview(tagView)
        
        self._updateScrollViewContentHeight()
    }
    
    func _addTagViews(_ tagViews: [TagView]) {
        let rearrangeIndex: Int = self._tagViews.count
        self._tagViews += tagViews
        for tagView in tagViews {
            self._scrollView.addSubview(tagView)
        }
        
        self._rearrangeTagViewsStartingFromIndex(
            rearrangeIndex,
            animated: false
        )
        self._updateScrollViewContentHeight()
    }
    
    func _removeTagView(_ tagView: TagView, animated: Bool) {
        tagView.removeFromSuperview()
        let index: Int = self._tagViews.index(of: tagView)!
        self._tagViews.remove(at: index)
        self._rearrangeTagViewsStartingFromIndex(index, animated: animated)
        
        self._updateScrollViewContentHeight()
    }
    
    func _removeAllTagViews() {
        for tagView in self._tagViews {
            tagView.removeFromSuperview()
        }
        self._tagViews = []
        self._updateScrollViewContentHeight()
    }
}
