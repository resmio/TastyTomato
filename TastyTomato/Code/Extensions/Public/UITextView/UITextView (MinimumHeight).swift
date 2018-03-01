//
//  UITextView (MinimumHeight).swift
//  TastyTomato
//
//  Created by Jan Nash (privat) on 01.03.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import SignificantSpices


// MARK: // Public
// MARK: Interface extension
public extension UITextView {
    public var minimumHeight: CGFloat {
        get { return self.associatedValue(for: &._minimumHeight) ?? self.height }
        set { self.associate(newValue, by: &._minimumHeight) }
    }
    
    // Functions
    public func changeHeightToFitText(maxHeight: CGFloat = .greatestFiniteMagnitude) {
        self.height = self.sizeThatFits(CGSize(width: self.width, height: maxHeight)).height
    }
}


// MARK: // Private
// MARK: - AssociationKeys
private extension ValueAssociationKey {
    static var _minimumHeight: ValueAssociationKey = ValueAssociationKey()
}
