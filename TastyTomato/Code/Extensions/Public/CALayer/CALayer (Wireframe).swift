//
//  CALayer (Wireframe).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
extension CALayer {
    func showAsWireframe() {
        self.showAsWireframe(withColor: UIColor.blackColor())
    }
    
    func showAsWireframe(withColor color: UIColor) {
        self._showAsWireframe(withColor: color)
    }
    
    func stopShowingAsWireframe() {
        self._stopShowingAsWireframe()
    }
}


// MARK: // Private
// MARK: Association Keys
private var _backupBackgroundColorAssociationKey: Void?
private var _backupBorderColorAssociationKey: Void?
private var _backupBorderWidthAssociationKey: Void?

private let _associationPolicy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN


// MARK: Start / Stop Showing As Wireframe
private extension CALayer {
    private func _showAsWireframe() {
        self.showAsWireframe(withColor: UIColor.lightGrayColor())
    }
    
    private func _showAsWireframe(withColor color: UIColor) {
        self._backupBackgroundColor()
        self._backupBorderColor()
        self._backupBorderWidth()
        
        self.backgroundColor = UIColor.clearColor().CGColor
        self.borderColor = color.CGColor
        self.borderWidth = 1.0
    }
    
    private func _stopShowingAsWireframe() {
        self._resetBackgroundColor()
        self._resetBorderColor()
        self._resetBorderWidth()
    }
}


// MARK: Backups / Resets
private extension CALayer {
    private func _backupBackgroundColor() {
        objc_setAssociatedObject(
            self,
            &_backupBackgroundColorAssociationKey,
            self.backgroundColor,
            _associationPolicy
        )
    }
    
    private func _backupBorderColor() {
        objc_setAssociatedObject(
            self,
            &_backupBorderColorAssociationKey,
            self.borderColor,
            _associationPolicy
        )
    }
    
    private func _backupBorderWidth() {
        objc_setAssociatedObject(
            self,
            &_backupBorderWidthAssociationKey,
            self.borderWidth,
            _associationPolicy
        )
    }
    
    private func _resetBackgroundColor() {
        self.backgroundColor = (objc_getAssociatedObject(
            self,
            &_backupBackgroundColorAssociationKey
            ) as! CGColor)
    }
    
    private func _resetBorderColor() {
        self.borderColor = (objc_getAssociatedObject(
            self,
            &_backupBorderColorAssociationKey
            ) as! CGColor)
    }
    
    private func _resetBorderWidth() {
        self.borderWidth = objc_getAssociatedObject(
            self,
            &_backupBorderWidthAssociationKey
            ) as! CGFloat
    }
}
