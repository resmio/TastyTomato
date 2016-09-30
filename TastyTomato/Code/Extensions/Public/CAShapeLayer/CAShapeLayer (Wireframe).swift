//
//  CAShapeLayer (Wireframe).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension CAShapeLayer {
    override public func showAsWireframe(withColor color: UIColor) {
        self._showAsWireframe(withColor: color)
    }
    
    override public func stopShowingAsWireframe() {
        self._stopShowingAsWireframe()
    }
}


// MARK: // Private
// MARK: Association Keys
private var _backupFillColorAssociationKey: Void?
private var _backupLineWidthAssociationKey: Void?
private var _backupStrokeColorAssociationKey: Void?

private let _associationPolicy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN


// MARK: Show As Wireframe / Reset
private extension CAShapeLayer {
    func _showAsWireframe(withColor color: UIColor) {
        self._backupFillColor()
        self._backupLineWidth()
        self._backupStrokeColor()
        
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 1.0
        self.strokeColor = color.cgColor
    }
    
    func _stopShowingAsWireframe() {
        self._resetFillColor()
        self._resetLineWidth()
        self._resetStrokeColor()
    }
}


// MARK: Backups / Resets
private extension CAShapeLayer {
    func _backupFillColor() {
        objc_setAssociatedObject(
            self,
            &_backupFillColorAssociationKey,
            self.backgroundColor,
            _associationPolicy
        )
    }
    
    func _backupLineWidth() {
        objc_setAssociatedObject(
            self,
            &_backupLineWidthAssociationKey,
            self.borderColor,
            _associationPolicy
        )
    }
    
    func _backupStrokeColor() {
        objc_setAssociatedObject(
            self,
            &_backupStrokeColorAssociationKey,
            self.borderWidth,
            _associationPolicy
        )
    }
    
    func _resetFillColor() {
        self.fillColor = (objc_getAssociatedObject(
            self,
            &_backupFillColorAssociationKey
            ) as! CGColor)
    }
    
    func _resetLineWidth() {
        self.lineWidth = objc_getAssociatedObject(
            self,
            &_backupLineWidthAssociationKey
            ) as! CGFloat
    }
    
    func _resetStrokeColor() {
        self.strokeColor = (objc_getAssociatedObject(
            self,
            &_backupStrokeColorAssociationKey
            ) as! CGColor)
    }
}
