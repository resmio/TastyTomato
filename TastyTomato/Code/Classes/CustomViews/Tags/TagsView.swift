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
    }
    
    // Private Constant Stored Properties
    private let _interItemSpacing: CGFloat = 5
    
    // Private Variable Stored Properties
    private var _scrollView: UIScrollView!
    private var _tagViews: [TagView] = []
}


// MARK: Layout Subviews Override
extension TagsView {
    public override func layoutSubviews() {
        self._scrollView.size = self.size
        self._rearrangeTagViewsStartingFromIndex(0)
        self._updateScrollViewContentHeight()
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
    
    private func _rearrangeTagViewsStartingFromIndex(index: Int) {
        let tagViews: [TagView] = Array(self._tagViews.suffixFrom(index))
        for tagView in tagViews {
            let newOrigin: CGPoint = self._originForTagView(tagView)
            if newOrigin != tagView.origin {
                tagView.origin = newOrigin
            }
        }
    }
    
    private func _updateScrollViewContentHeight() {
        if let lastTagView: TagView = self._tagViews.last {
            let height: CGFloat = max(lastTagView.bottom, self.height)
            self._scrollView.contentSize.height = height
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
        self._rearrangeTagViewsStartingFromIndex(index)
        
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
