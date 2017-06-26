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
        return self._isScrolledToTop
    }
    
    public var isScrolledToBottom: Bool {
        return self._isScrolledToBottom
    }
}


// MARK: // Private
// MARK: Implementation
private extension UIScrollView {
    var _isScrolledToTop: Bool {
        let verticalContentOffset: CGFloat = self.contentOffset.y
        let offsetForTop: CGFloat = -self.contentInset.top
        return verticalContentOffset <= offsetForTop
    }
    
    var _isScrolledToBottom: Bool {
        let verticalContentOffset: CGFloat = self.contentOffset.y
        let scrollContentHeight: CGFloat = self.contentSize.height
        let bottomInset: CGFloat = self.contentInset.bottom
        let scrollViewHeight: CGFloat = self.bounds.height
        let offsetForBottom: CGFloat = scrollContentHeight + bottomInset - scrollViewHeight
        return verticalContentOffset >= offsetForBottom
    }
}
