//
//  UIScrollView (ScrollingConvenience).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/26/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIScrollView {
    public var isScrolledToTop: Bool {
        return self.willBeScrolledToTop(withVerticalContentOffset: self.contentOffset.y)
    }
    
    public var isScrolledToBottom: Bool {
        return self.willBeScrolledToBottom(withVerticalContentOffset: self.contentOffset.y)
    }
    
    public func willBeScrolledToTop(withVerticalContentOffset verticalContentOffset: CGFloat) -> Bool {
        return self._willBeScrolledToTop(withVerticalContentOffset: verticalContentOffset)
    }
    
    public func willBeScrolledToBottom(withVerticalContentOffset verticalContentOffset: CGFloat) -> Bool {
        return self._willBeScrolledToBottom(withVerticalContentOffset: verticalContentOffset)
    }
}


// MARK: // Private
// MARK: Implementation
private extension UIScrollView {
    func _willBeScrolledToTop(withVerticalContentOffset verticalContentOffset: CGFloat) -> Bool {
        let offsetForTop: CGFloat = -self.contentInset.top
        return verticalContentOffset <= offsetForTop
    }
    
    func _willBeScrolledToBottom(withVerticalContentOffset verticalContentOffset: CGFloat) -> Bool {
        let scrollContentHeight: CGFloat = self.contentSize.height
        let bottomInset: CGFloat = self.contentInset.bottom
        let scrollViewHeight: CGFloat = self.bounds.height
        let offsetForBottom: CGFloat = scrollContentHeight + bottomInset - scrollViewHeight
        return verticalContentOffset >= offsetForBottom
    }
}
