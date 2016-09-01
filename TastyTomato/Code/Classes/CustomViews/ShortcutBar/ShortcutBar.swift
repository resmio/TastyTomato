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
    public func setItems(items: [UIBarButtonItem], animated: Bool) {
        self._setItems(items, animated: animated)
    }
}


// MARK: Class Declaration
public class ShortcutBar: UIView {
    // Init
    public convenience init() {
        let width: CGFloat = UIScreen.mainScreen().bounds.width
        self.init(frame: CGRect(size: CGSize(width: width, height: 44)))
        self._setup()
    }
    
    // Private Constant Stored Properties
    private let _scrollView: UIScrollView = UIScrollView()
    private let _toolBar: UIToolbar = UIToolbar()
    
    // Layout
    // That's just guessed and adjusted by trial and error...
    private let _interItemSpacing: CGFloat = 10
    private let _itemPadding: CGFloat = 30
    
    // Design
    private let _backgroundColor: UIColor = UIColor.LightKeyboardBackground()
}


// MARK: // Private
// MARK: Setup
private extension ShortcutBar {
    private func _setup() {
        self._setupScrollView()
        self._setupToolbar()
        self._setupGradientLayer()
    }
    
    private func _setupScrollView() {
        let size: CGSize = self.size
        
        let scrollView: UIScrollView = self._scrollView
        scrollView.backgroundColor = self._backgroundColor
        scrollView.size = size
        scrollView.contentSize = size
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        self.addSubview(scrollView)
    }
    
    private func _setupToolbar() {
        let toolBar: UIToolbar = self._toolBar
        toolBar.barTintColor = self._backgroundColor
        toolBar.size = self.size
        self._scrollView.addSubview(toolBar)
    }
    
    private func _setupGradientLayer() {
        
    }
}


// MARK: Interface Implementation
private extension ShortcutBar {
    private func _setItems(items: [UIBarButtonItem], animated: Bool) {
        var cumulativeWidth: CGFloat = 0
        for item in items {
            cumulativeWidth += item.customView?.width ?? item.width
            cumulativeWidth += self._interItemSpacing
        }
        
        // Fixed padding
        cumulativeWidth += self._itemPadding
        
        let toolBar: UIToolbar = self._toolBar
        toolBar.setItems(items, animated: animated)
        
        UIView.animateWithDuration(animated ? 0.3 : 0) {
            toolBar.width = cumulativeWidth
            self._scrollView.contentSize.width = cumulativeWidth
            
            if cumulativeWidth < self.width {
                toolBar.centerHInSuperview()
            } else {
                toolBar.left = 0
            }
        }
    }
}
