//
//  UITextView (MinimumHeight).swift
//  TastyTomato
//
//  Created by Jan Nash (privat) on 01.03.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import SignificantSpices


// MARK: // Internal
// MARK: Interface extension
extension UITextView {
    var minimumHeight: CGFloat {
        get { return self.associatedValue(for: &._minimumHeight) ?? self.height }
        set { self.associate(newValue, by: &._minimumHeight) }
    }
    
    // Functions
    func changeHeightToFitText(maxHeight: CGFloat = .greatestFiniteMagnitude) {
        self._changeHeightToFitText(maxHeight: maxHeight)
    }
}


// MARK: // Private
// MARK: - AssociationKeys
private extension ValueAssociationKey {
    static var _minimumHeight: ValueAssociationKey = ValueAssociationKey()
}


// MARK: Functions
private extension UITextView {
    func _changeHeightToFitText(maxHeight: CGFloat) {
        self.height = self.sizeThatFits(CGSize(width: self.width, height: maxHeight)).height
    }
}
