//
//  UIView (TemporaryPositionAndDimensions).swift
//  TastyTomato
//
//  Created by Jan Nash on 9/11/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit
import SignificantSpices


// MARK: // Public
public extension UIView {
    // Readonly
    public var tempX: CGFloat? {
        return self._tempX
    }
    
    public var tempY: CGFloat? {
        return self._tempY
    }
    
    public var tempWidth: CGFloat? {
        return self._tempWidth
    }
    
    public var tempHeight: CGFloat? {
        return self._tempHeight
    }
    
    // Functions
    public func setTempX(_ tempX: CGFloat) {
        self._setTempX(tempX)
    }
    
    public func setTempY(_ tempY: CGFloat) {
        self._setTempY(tempY)
    }
    
    public func setTempWidth(_ tempWidth: CGFloat) {
        self._setTempWidth(tempWidth)
    }
    
    public func setTempHeight(_ tempHeight: CGFloat) {
        self._setTempHeight(tempHeight)
    }
    
    public func resetX() {
        self._resetX()
    }
    
    public func resetY() {
        self._resetY()
    }
    
    public func resetWidth() {
        self._resetWidth()
    }
    
    public func resetHeight() {
        self._resetHeight()
    }
}

// MARK: // Internal
// MARK: AssociationOwner
extension UIView: AssociationOwner {}


// MARK: // Private
// MARK: AssociationKeys
private extension ValueAssociationKey {
    static var _XBackup: ValueAssociationKey = ValueAssociationKey()
    static var _XTemp: ValueAssociationKey = ValueAssociationKey()
    static var _YBackup: ValueAssociationKey = ValueAssociationKey()
    static var _YTemp: ValueAssociationKey = ValueAssociationKey()
    static var _WidthBackup: ValueAssociationKey = ValueAssociationKey()
    static var _WidthTemp: ValueAssociationKey = ValueAssociationKey()
    static var _HeightBackup: ValueAssociationKey = ValueAssociationKey()
    static var _HeightTemp: ValueAssociationKey = ValueAssociationKey()
}


// MARK: Associated Variables
private extension UIView {
    var _tempX: CGFloat? {
        get {
            return self.associatedValue(for: &._XTemp)
        }
        set(newTempX) {
            self.associate(newTempX, by: &._XTemp)
        }
    }
    
    var _originalXBackup: CGFloat? {
        get {
            return self.associatedValue(for: &._XBackup)
        }
        set(newOriginalX) {
            self.associate(newOriginalX, by: &._XBackup)
        }
    }
    
    var _tempY: CGFloat? {
        get {
            return self.associatedValue(for: &._YTemp)
        }
        set(newTempY) {
            self.associate(newTempY, by: &._YTemp)
        }
    }
    
    var _originalYBackup: CGFloat? {
        get {
            return self.associatedValue(for: &._YBackup)
        }
        set(newOriginalY) {
            self.associate(newOriginalY, by: &._YBackup)
        }
    }
    
    var _tempWidth: CGFloat? {
        get {
            return self.associatedValue(for: &._WidthTemp)
        }
        set(newTempWidth) {
            self.associate(newTempWidth, by: &._WidthTemp)
        }
    }
    
    var _originalWidthBackup: CGFloat? {
        get {
            return self.associatedValue(for: &._WidthBackup)
        }
        set(newOriginalWidth) {
            self.associate(newOriginalWidth, by: &._WidthBackup)
        }
    }
    
    var _tempHeight: CGFloat? {
        get {
            return self.associatedValue(for: &._HeightTemp)
        }
        set(newTempHeight) {
            self.associate(newTempHeight, by: &._HeightTemp)
        }
    }
    
    var _originalHeightBackup: CGFloat? {
        get {
            return self.associatedValue(for: &._HeightBackup)
        }
        set(newOriginalHeight) {
            self.associate(newOriginalHeight, by: &._HeightBackup)
        }
    }
}


// MARK: Sets
private extension UIView {
    func _setTempX(_ tempX: CGFloat) {
        self._setTemp(
            setter: &self.left,
            tempValue: tempX,
            tempSave: &self._tempX,
            originalBackup: &self._originalXBackup
        )
    }
    
    func _setTempY(_ tempY: CGFloat) {
        self._setTemp(
            setter: &self.top,
            tempValue: tempY,
            tempSave: &self._tempY,
            originalBackup: &self._originalYBackup
        )
    }
    
    func _setTempWidth(_ tempWidth: CGFloat) {
        self._setTemp(
            setter: &self.width,
            tempValue: tempWidth,
            tempSave: &self._tempWidth,
            originalBackup: &self._originalWidthBackup
        )
    }
    
    func _setTempHeight(_ tempHeight: CGFloat) {
        self._setTemp(
            setter: &self.height,
            tempValue: tempHeight,
            tempSave: &self._tempHeight,
            originalBackup: &self._originalHeightBackup
        )
    }
    
    // Private Helper
    private func _setTemp(setter: inout CGFloat, tempValue: CGFloat, tempSave: inout CGFloat?, originalBackup: inout CGFloat?) {
        if originalBackup == nil {
            originalBackup = setter
        }
        setter = tempValue
        tempSave = tempValue
    }
}


// MARK: Resets
private extension UIView {
    func _resetX() {
        self._reset(
            setter: &self.left,
            originalBackup: &self._originalXBackup,
            tempSave: &self._tempX
        )
    }
    
    func _resetY() {
        self._reset(
            setter: &self.top,
            originalBackup: &self._originalYBackup,
            tempSave: &self._tempY
        )
    }
    
    func _resetWidth() {
        self._reset(
            setter: &self.width,
            originalBackup: &self._originalWidthBackup,
            tempSave: &self._tempWidth
        )
    }
    
    func _resetHeight() {
        self._reset(
            setter: &self.height,
            originalBackup: &self._originalHeightBackup,
            tempSave: &self._tempHeight
        )
    }
    
    // Private Helper
    private func _reset(setter: inout CGFloat, originalBackup: inout CGFloat?, tempSave: inout CGFloat?) {
        if let original: CGFloat = originalBackup {
            setter = original
            originalBackup = nil
            tempSave = nil
        }
    }
}
