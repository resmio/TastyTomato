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
public protocol TagsViewDelegate: class {
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
    
    var showsGradient: Bool {
        get {
            return self._showsGradient
        }
        set(newShowsGradient) {
            self._showsGradient = newShowsGradient
        }
    }
    
    // Functions
    public func rearrangeTagViews() {
        self._rearrangeTagViews(startIndex: 0, width: self.width, animated: false)
    }
    
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
    fileprivate static let _gradientHeight: CGFloat = 20
    fileprivate static let _rowHeightWithSpacing: CGFloat = TagView.defaultHeight + TagsView._interItemSpacing
    
    // Private Weak Variables
    fileprivate weak var _delegate: TagsViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _scrollView: UIScrollView = UIScrollView()
    
    // Private Variables
    fileprivate var _tagViews: [TagView] = []
    fileprivate var __gradientLayer: CAGradientLayer?
    fileprivate var __showsGradient: Bool = false
    
    
    // Layout Overrides
    public override func layoutSubviews() {
        self._layoutSubviews()
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension TagsView {
    // Readonly
    var _gradientLayer: CAGradientLayer {
        return self.__gradientLayer ?? {
            let white: UIColor = .white
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame.size.height = TagsView._gradientHeight
            gradient.colors = [white.withAlpha(0).cgColor, white.cgColor]
            self.__gradientLayer = gradient
            return gradient
        }()
    }
    
    // ReadWrite
    var _showsGradient: Bool {
        get {
            return self.__showsGradient
        }
        set(newShowsGradient) {
            guard newShowsGradient != self.__showsGradient else { return }
            self.__showsGradient = newShowsGradient
            self._showGradientLayer(newShowsGradient)
        }
    }
    
    // Private Helpers
    private func _showGradientLayer(_ show: Bool) {
        if show {
            self.layer.addSublayer(self._gradientLayer)
        } else {
            self.__gradientLayer?.removeFromSuperlayer()
            self.__gradientLayer = nil
        }
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
    
        if let gradientLayer: CAGradientLayer = self.__gradientLayer {
            gradientLayer.frame.bottom = self.height
            gradientLayer.frame.size.width = width
        }
    }
    
    // Private Helper
    func _rearrangeTagViews(startIndex: Int, width: CGFloat, animated: Bool) {
        let tagViews: [TagView] = self._tagViews
        
        if tagViews.isEmpty {
            self._scrollView.contentSize.height = 0
            self.delegate?.changedContentHeight(to: 0, in: self)
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
        self._scrollView.contentSize.height = newContentHeight
        self.delegate?.changedContentHeight(to: newContentHeight, in: self)
        
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            zip(tagViewsToUpdate, origins).forEach({ $0.0.origin = $0.1 })
        }
    }
}


// MARK: Add Subviews
private extension TagsView {
    func _addSubviews() {
        self.addSubview(self._scrollView)
        if self.showsGradient {
            self.layer.addSublayer(self._gradientLayer)
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
        guard let index: Int = self._tagViews.index(of: tagView) else { return }
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
