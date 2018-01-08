//
//  ShortcutBar.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/30/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
public extension ShortcutBar {
    public func setItems(_ items: [UIBarButtonItem], animated: Bool) {
        self._setItems(items, animated: animated)
    }
}


// MARK: Class Declaration
public class ShortcutBar: UIView {
    // Init
    public convenience init() {
        let width: CGFloat = UIScreen.main.bounds.width
        self.init(frame: CGRect(size: CGSize(width: width, height: 44)))
        self._setup()
    }
    
    // Private Constant Stored Properties
    fileprivate let _scrollView: UIScrollView = UIScrollView()
    fileprivate let _toolBar: UIToolbar = UIToolbar()
    fileprivate let _leftGradientLayer: CAGradientLayer = CAGradientLayer()
    fileprivate let _rightGradientLayer: CAGradientLayer = CAGradientLayer()
    
    // Layout
    // These two are guessed and adjusted by trial and error...
    fileprivate let _interItemSpacing: CGFloat = 10
    fileprivate let _itemPadding: CGFloat = 30
    
    fileprivate let _gradientLayerWidth: CGFloat = 20
    
    // Design
    fileprivate let _backgroundColor: UIColor = .lightKeyboardBackground
}


// MARK: // Private
// MARK: Setup
private extension ShortcutBar {
    func _setup() {
        self._setupScrollView()
        self._setupToolbar()
        self._setupGradientLayer()
    }
    
    func _setupScrollView() {
        let size: CGSize = self.size
        
        let scrollView: UIScrollView = self._scrollView
        scrollView.backgroundColor = self._backgroundColor
        scrollView.size = size
        scrollView.contentSize = size
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        self.addSubview(scrollView)
    }
    
    func _setupToolbar() {
        let toolBar: UIToolbar = self._toolBar
        toolBar.barTintColor = self._backgroundColor
        toolBar.size = self.size
        self._scrollView.addSubview(toolBar)
    }
    
    func _setupGradientLayer() {
        let color: UIColor = self._backgroundColor
        let origin: CGPoint = CGPoint(x: self.width - self._gradientLayerWidth)
        let size: CGSize = CGSize(width: self._gradientLayerWidth, height: self.height)
        
        let leftGradientLayer: CAGradientLayer = self._leftGradientLayer
        leftGradientLayer.frame = CGRect(origin: origin, size: size)
        leftGradientLayer.startPoint = CGPoint(y: 0.5)
        leftGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        leftGradientLayer.colors = [color.withAlpha(0).cgColor, color.cgColor]
        
        let rightGradientLayer: CAGradientLayer = self._rightGradientLayer
        rightGradientLayer.frame = CGRect(size: size)
        rightGradientLayer.startPoint = CGPoint(y: 0.5)
        rightGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        rightGradientLayer.colors = [color.cgColor, color.withAlpha(0).cgColor]
        
        self.layer.addSublayer(leftGradientLayer)
        self.layer.addSublayer(rightGradientLayer)
    }
}


// MARK: Interface Implementation
private extension ShortcutBar {
    func _setItems(_ items: [UIBarButtonItem], animated: Bool) {
        let toolBar: UIToolbar = self._toolBar
        
        let spacer: () -> UIBarButtonItem = {
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        }
        var itemsWithSpacers: [UIBarButtonItem] = [spacer()]
        var cumulativeWidth: CGFloat = 0
        for item in items {
            cumulativeWidth += item.customView?.width ?? item.width
            cumulativeWidth += self._interItemSpacing
            itemsWithSpacers.append(contentsOf: [item, spacer()])
        }
        
        // Fixed padding
        cumulativeWidth += self._itemPadding
        
        toolBar.setItems(itemsWithSpacers, animated: animated)
        
        let isNarrowerOrSameWidth: Bool = cumulativeWidth <= self.width
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            toolBar.width = cumulativeWidth
            self._scrollView.contentSize.width = cumulativeWidth
            
            if isNarrowerOrSameWidth {
                toolBar.centerHInSuperview()
            } else {
                toolBar.left = 0
            }
            
            self._leftGradientLayer.isHidden = isNarrowerOrSameWidth
            self._rightGradientLayer.isHidden = isNarrowerOrSameWidth
        }) 
    }
}
