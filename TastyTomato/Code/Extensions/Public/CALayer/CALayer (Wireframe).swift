//
//  CALayer (Wireframe).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CALayer {
    public func showAsWireframe() {
        self.showAsWireframe(withColor: UIColor.black)
    }
    
    public func showAsWireframe(withColor color: UIColor) {
        self._showAsWireframe(withColor: color)
    }
    
    public func stopShowingAsWireframe() {
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
    func _showAsWireframe() {
        self.showAsWireframe(withColor: UIColor.lightGray)
    }
    
    func _showAsWireframe(withColor color: UIColor) {
        self._backupBackgroundColor()
        self._backupBorderColor()
        self._backupBorderWidth()
        
        self.backgroundColor = UIColor.clear.cgColor
        self.borderColor = color.cgColor
        self.borderWidth = 1.0
    }
    
    func _stopShowingAsWireframe() {
        self._resetBackgroundColor()
        self._resetBorderColor()
        self._resetBorderWidth()
    }
}


// MARK: Backups / Resets
private extension CALayer {
    func _backupBackgroundColor() {
        objc_setAssociatedObject(
            self,
            &_backupBackgroundColorAssociationKey,
            self.backgroundColor,
            _associationPolicy
        )
    }
    
    func _backupBorderColor() {
        objc_setAssociatedObject(
            self,
            &_backupBorderColorAssociationKey,
            self.borderColor,
            _associationPolicy
        )
    }
    
    func _backupBorderWidth() {
        objc_setAssociatedObject(
            self,
            &_backupBorderWidthAssociationKey,
            self.borderWidth,
            _associationPolicy
        )
    }
    
    func _resetBackgroundColor() {
        self.backgroundColor = (objc_getAssociatedObject(
            self,
            &_backupBackgroundColorAssociationKey
            ) as! CGColor)
    }
    
    func _resetBorderColor() {
        self.borderColor = (objc_getAssociatedObject(
            self,
            &_backupBorderColorAssociationKey
            ) as! CGColor)
    }
    
    func _resetBorderWidth() {
        self.borderWidth = objc_getAssociatedObject(
            self,
            &_backupBorderWidthAssociationKey
            ) as! CGFloat
    }
}
