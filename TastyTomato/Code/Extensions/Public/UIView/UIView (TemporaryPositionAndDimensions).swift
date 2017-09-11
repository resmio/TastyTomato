//
//  UIView (TemporaryPositionAndDimensions).swift
//  TastyTomato
//
//  Created by Jan Nash on 9/11/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
extension UIView {
    // Readonly
    var tempX: CGFloat? {
        return self._tempX
    }
    
    var tempY: CGFloat? {
        return self._tempY
    }
    
    var tempWidth: CGFloat? {
        return self._tempWidth
    }
    
    var tempHeight: CGFloat? {
        return self._tempHeight
    }
    
    // Functions
    func setTempX(_ tempX: CGFloat) {
        self._setTempX(tempX)
    }
    
    func setTempY(_ tempY: CGFloat) {
        self._setTempY(tempY)
    }
    
    func setTempWidth(_ tempWidth: CGFloat) {
        self._setTempWidth(tempWidth)
    }
    
    func setTempHeight(_ tempHeight: CGFloat) {
        self._setTempHeight(tempHeight)
    }
    
    func resetX() {
        self._resetX()
    }
    
    func resetY() {
        self._resetY()
    }
    
    func resetWidth() {
        self._resetWidth()
    }
    
    func resetHeight() {
        self._resetHeight()
    }
}


// MARK: // Private
// MARK: AssociationKeys
private struct _AssociationKeys {
    struct X {
        static var backupKey: Void?
        static var tempKey: Void?
    }
    struct Y {
        static var backupKey: Void?
        static var tempKey: Void?
    }
    struct Width {
        static var backupKey: Void?
        static var tempKey: Void?
    }
    struct Height {
        static var backupKey: Void?
        static var tempKey: Void?
    }
}


// MARK: Associated Variables
private extension UIView {
    var _tempX: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.X.tempKey)
        }
        set(newTempX) {
            self.associate(newTempX, .strongly, by: &_AssociationKeys.X.tempKey)
        }
    }
    
    var _originalXBackup: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.X.backupKey)
        }
        set(newOriginalX) {
            self.associate(newOriginalX, .strongly, by: &_AssociationKeys.X.backupKey)
        }
    }
    
    var _tempY: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.Y.tempKey)
        }
        set(newTempY) {
            self.associate(newTempY, .strongly, by: &_AssociationKeys.Y.tempKey)
        }
    }
    
    var _originalYBackup: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.Y.backupKey)
        }
        set(newOriginalY) {
            self.associate(newOriginalY, .strongly, by: &_AssociationKeys.Y.backupKey)
        }
    }
    
    var _tempWidth: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.Width.tempKey)
        }
        set(newTempWidth) {
            self.associate(newTempWidth, .strongly, by: &_AssociationKeys.Width.tempKey)
        }
    }
    
    var _originalWidthBackup: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.Width.backupKey)
        }
        set(newOriginalWidth) {
            self.associate(newOriginalWidth, .strongly, by: &_AssociationKeys.Width.backupKey)
        }
    }
    
    var _tempHeight: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.Height.tempKey)
        }
        set(newTempHeight) {
            self.associate(newTempHeight, .strongly, by: &_AssociationKeys.Height.tempKey)
        }
    }
    
    var _originalHeightBackup: CGFloat? {
        get {
            return self.associatedValue(for: &_AssociationKeys.Height.backupKey)
        }
        set(newOriginalHeight) {
            self.associate(newOriginalHeight, .strongly, by: &_AssociationKeys.Height.backupKey)
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
