//
//  UIView (TemporaryPositionAndDimensions).swift
//  TastyTomato
//
//  Created by Jan Nash on 9/11/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit
import SignificantSpices


/**
 This extension provides functionality to temporarily change the position and dimensions
 of Views.  You might for example use it to reduce the height of a UITextView, so it is
 not hidden beneath the keyboard, or to move the complete window upwards, so a focussed
 UITextField is not hidden beneath the keyboard.  The main advantage of using this
 extension is the fact that you don't have to backup the original position/dimensions
 in your viewcontroller.  Instead, it is completely encapsulated in the View.
 */

// MARK: // Public
public extension UIView {
    // Readonly
    // Temporary position and dimensions
    /**
     The temporary x-position of the view.  nil, if no temporary x is set.
     */
    var tempX: CGFloat? {
        return self._tempX
    }
    
    /**
     The temporary y-position of the view.  nil, if no temporary y is set.
     */
    var tempY: CGFloat? {
        return self._tempY
    }
    
    /**
     The temporary width of the view.  nil, if no temporary width is set.
     */
    var tempWidth: CGFloat? {
        return self._tempWidth
    }
    
    /**
     The temporary height of the view.  nil, if no temporary height is set.
     */
    var tempHeight: CGFloat? {
        return self._tempHeight
    }
    
    // Original dimensions
    /**
     The original x-position of the view.  frame.origin.x, if no temporary x is set.
     */
    var originalX: CGFloat {
        return self._originalX ?? self.frame.origin.x
    }
    
    /**
     The original y-position of the view.  frame.origin.y, if no temporary y is set.
     */
    var originalY: CGFloat {
        return self._originalY ?? self.frame.origin.y
    }
    
    /**
     The original width of the view.  frame.size.width, if no temporary width is set.
     */
    var originalWidth: CGFloat {
        return self._originalWidth ?? self.frame.size.width
    }
    
    /**
     The original height of the view.  frame.size.height, if no temporary height is set.
     */
    var originalHeight: CGFloat {
        return self._originalHeight ?? self.frame.size.height
    }
    
    // Offsets
    /**
     The current x-offset of the view.  0, if no temporary x is set.
     */
    var xOffset: CGFloat {
        return (self.tempX ?? self.originalX) - self.originalX
    }
    
    /**
     The current y-offset of the view.  0, if no temporary y is set.
     */
    var yOffset: CGFloat {
        return (self.tempY ?? self.originalY) - self.originalY
    }
    
    /**
     The current width-offset of the view.  0, if no temporary width is set.
     */
    var widthOffset: CGFloat {
        return (self.tempWidth ?? self.originalWidth) - self.originalWidth
    }
    
    /**
     The current height-offset of the view.  0, if no temporary height is set.
     */
    var heightOffset: CGFloat {
        return (self.tempHeight ?? self.originalHeight) - self.originalHeight
    }
    
    // Functions
    /**
     Sets the temporary x position of the view.
     */
    func setTempX(_ tempX: CGFloat) {
        self._setTempX(tempX)
    }
    
    /**
     Sets the temporary y position of the view.
     */
    func setTempY(_ tempY: CGFloat) {
        self._setTempY(tempY)
    }
    
    /**
     Sets the temporary width of the view.
     */
    func setTempWidth(_ tempWidth: CGFloat) {
        self._setTempWidth(tempWidth)
    }
    
    /**
     Sets the temporary height of the view.
     */
    func setTempHeight(_ tempHeight: CGFloat) {
        self._setTempHeight(tempHeight)
    }
    
    /**
     Resets the x-position of the view to its original value.
     */
    func resetX() {
        self._resetX()
    }
    
    /**
     Resets the y-position of the view to its original value.
     */
    func resetY() {
        self._resetY()
    }
    
    /**
     Resets the width of the view to its original value.
     */
    func resetWidth() {
        self._resetWidth()
    }
    
    /**
     Resets the height of the view to its original value.
     */
    func resetHeight() {
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
    
    var _originalX: CGFloat? {
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
    
    var _originalY: CGFloat? {
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
    
    var _originalWidth: CGFloat? {
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
    
    var _originalHeight: CGFloat? {
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
            originalBackup: &self._originalX
        )
    }
    
    func _setTempY(_ tempY: CGFloat) {
        self._setTemp(
            setter: &self.top,
            tempValue: tempY,
            tempSave: &self._tempY,
            originalBackup: &self._originalY
        )
    }
    
    func _setTempWidth(_ tempWidth: CGFloat) {
        self._setTemp(
            setter: &self.width,
            tempValue: tempWidth,
            tempSave: &self._tempWidth,
            originalBackup: &self._originalWidth
        )
    }
    
    func _setTempHeight(_ tempHeight: CGFloat) {
        self._setTemp(
            setter: &self.height,
            tempValue: tempHeight,
            tempSave: &self._tempHeight,
            originalBackup: &self._originalHeight
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
            originalBackup: &self._originalX,
            tempSave: &self._tempX
        )
    }
    
    func _resetY() {
        self._reset(
            setter: &self.top,
            originalBackup: &self._originalY,
            tempSave: &self._tempY
        )
    }
    
    func _resetWidth() {
        self._reset(
            setter: &self.width,
            originalBackup: &self._originalWidth,
            tempSave: &self._tempWidth
        )
    }
    
    func _resetHeight() {
        self._reset(
            setter: &self.height,
            originalBackup: &self._originalHeight,
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
