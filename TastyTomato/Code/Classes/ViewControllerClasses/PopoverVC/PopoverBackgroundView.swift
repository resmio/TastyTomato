//
//  PopoverBackgroundView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 09.08.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: Class Declaration / Interface
class RAPopoverBackgroundView: UIPopoverBackgroundView {
    // Interface
    class var backgroundColor: UIColor {
        get {
            return self._backgroundColor
        }
        set(newBackgroundColor) {
            self._backgroundColor = newBackgroundColor
        }
    }
    
    class var dimsBackground: Bool {
        get {
            return self._dimsBackground
        }
        set(newDimsBackground) {
            self._dimsBackground = newDimsBackground
        }
    }
    
    class var displaysBorderShadow: Bool {
        get {
            return self._displaysBorderShadow
        }
        set(newDisplaysBorderShadow) {
            self._displaysBorderShadow = newDisplaysBorderShadow
        }
    }
    
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        fatalError("RAPopoverBackgroundView does not support NSCoding!")
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self._addSubviews()
    }
    
    // Private Static Constants
    fileprivate static let _defaultArrowBase: CGFloat = 18
    fileprivate static let _defaultContentViewInsets: UIEdgeInsets = .zero
    
    // Private Static Variables
    fileprivate static var _backgroundColor: UIColor = .white
    fileprivate static var _dimsBackground: Bool = true
    fileprivate static var _displaysBorderShadow: Bool = true
    
    // Private Lazy Variables
    fileprivate lazy var _borderView: UIView = self._createBorderView()
    fileprivate lazy var _arrowView: TriangleView = self._createArrowView()
    
    // Private Variables
    fileprivate var __arrowOffset: CGFloat = 0
    fileprivate var __arrowDirection: UIPopoverArrowDirection = .any
    fileprivate var _borderShadowView: UIView?
    fileprivate var _arrowShadowView: TriangleView?
    
    
    // Static Overrides
    override static func arrowBase() -> CGFloat {
        return self._defaultArrowBase
    }
    
    override static func arrowHeight() -> CGFloat {
        return self._arrowHeight()
    }
    
    override static func contentViewInsets() -> UIEdgeInsets {
        return self._defaultContentViewInsets
    }
    
    override class var wantsDefaultContentAppearance: Bool {
        return false
    }
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
    
    override var arrowOffset: CGFloat {
        get {
            return self._arrowOffset
        }
        set(newArrowOffset) {
            self._arrowOffset = newArrowOffset
        }
    }
    
    override var arrowDirection: UIPopoverArrowDirection {
        get {
            return self._arrowDirection
        }
        set(newArrowDirection) {
            self._arrowDirection = newArrowDirection
        }
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension RAPopoverBackgroundView {
    func _createBorderView() -> UIView {
        let borderView: UIView = UIView()
        borderView.backgroundColor = type(of: self).backgroundColor
        return borderView
    }
    
    func _createArrowView() -> TriangleView {
        let arrowView: TriangleView = TriangleView(baseWidth: type(of: self).arrowBase())
        arrowView.backgroundColor = type(of: self).backgroundColor
        return arrowView
    }
    
    func _createBorderShadowView() -> UIView {
        let borderShadowView: UIView = UIView()
        let layer: CALayer = borderShadowView.layer
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
        layer.shadowPath = UIBezierPath(rect: layer.bounds).cgPath
        layer.masksToBounds = false
        return borderShadowView
    }
    
    func _createArrowShadowView() -> TriangleView {
        let arrowShadowView: TriangleView = TriangleView(baseWidth: type(of: self)._arrowShadowBase())
        let layer: CALayer = arrowShadowView.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
        layer.shadowPath = arrowShadowView.trianglePath()
        layer.masksToBounds = false
        return arrowShadowView
    }
}


// MARK: Computed Variables
private extension RAPopoverBackgroundView {
    var _arrowOffset: CGFloat {
        get {
            return self.__arrowOffset
        }
        set(newArrowOffset) {
            guard newArrowOffset != self.__arrowOffset else { return }
            self.__arrowOffset = newArrowOffset
            self.setNeedsLayout()
        }
    }
    
    var _arrowDirection: UIPopoverArrowDirection {
        get {
            return self.__arrowDirection
        }
        set(newArrowDirection) {
            guard newArrowDirection != self.__arrowDirection else { return }
            self.__arrowDirection = newArrowDirection
            self.setNeedsLayout()
        }
    }
}


// MARK: Arrow Shadow Helpers
private extension RAPopoverBackgroundView {
    class func _arrowHeight() -> CGFloat {
        return ((self.arrowBase() / 2) * sqrt(CGFloat(3.0))) - 1
    }
    
    class func _arrowShadowBase() -> CGFloat {
        return self.arrowBase() + 4
    }
    
    class func _arrowShadowHeight() -> CGFloat {
        return ((self._arrowShadowBase() / 2) * sqrt(CGFloat(3.0))) - 1
    }
}


// MARK: Layout Override Implementations
private extension RAPopoverBackgroundView {
    func _layoutSubviews() {
        // No super-call here, so we get rid of the
        // default shadow and can create our own
        let width: CGFloat = self.width
        let height: CGFloat = self.height
        
        let arrowDirection: UIPopoverArrowDirection = self.arrowDirection
        let arrowOffset: CGFloat = self.arrowOffset
        let arrowHeight: CGFloat = type(of: self).arrowHeight()
        let arrowBase: CGFloat = type(of: self).arrowBase()
        
        var borderX: CGFloat = 0
        var borderY: CGFloat = 0
        var borderWidth: CGFloat = self.width
        var borderHeight: CGFloat = self.height
        
        var arrowX: CGFloat = 0
        var arrowY: CGFloat = 0
        
        var rotation: CGAffineTransform = .identity
        var arrowShouldBeHidden: Bool = false
        
        // The strange added and subtracted '1' in those 4 cases is there to compensate
        // rounding problems that sometimes lead to a small gap between the arrow and the rect.
        switch arrowDirection {
        case UIPopoverArrowDirection.up:
            borderY += arrowHeight
            borderHeight -= arrowHeight
            arrowX = ((width - arrowBase) / 2) + arrowOffset
            arrowY = 1
        case UIPopoverArrowDirection.down:
            borderHeight -= arrowHeight
            arrowX = ((width - arrowBase) / 2) + arrowOffset
            arrowY = borderHeight - 1
            rotation = CGAffineTransform(rotationAngle: .pi)
        case UIPopoverArrowDirection.left:
            borderX += arrowHeight
            borderWidth -= arrowHeight
            arrowX = 1
            arrowY = ((height - arrowHeight) / 2) + arrowOffset
            rotation = CGAffineTransform(rotationAngle: -.pi / 2)
        case UIPopoverArrowDirection.right:
            borderWidth -= arrowHeight
            arrowX = borderWidth - 1
            arrowY = ((height - arrowHeight) / 2) + arrowOffset
            rotation = CGAffineTransform(rotationAngle: .pi / 2)
        case UIPopoverArrowDirection.any, UIPopoverArrowDirection.unknown:
            fallthrough
        default:
            // You might think that the default will never be executed,
            // since it seems to be exhaustive...
            // Alas, when the popover is presented with allowedArrowDirections = 0,
            // none of the above 6 cases is executed. Why? No idea...
            arrowShouldBeHidden = true
        }
        
        // Insetting and making smaller, so the shadow overlaps
        self._borderView.frame = CGRect(
            x: borderX + 1,
            y: borderY + 1,
            width: borderWidth - 2,
            height: borderHeight - 2
        )
        
        let arrowView: TriangleView = self._arrowView
        arrowView.isHidden = arrowShouldBeHidden
        arrowView.origin = CGPoint(x: arrowX, y: arrowY)
        arrowView.transform = rotation
        
        if let borderShadowView: UIView = self._borderShadowView {
            borderShadowView.frame = CGRect(x: borderX, y: borderY, width: borderWidth, height: borderHeight)
            borderShadowView.layer.shadowPath = UIBezierPath(rect: borderShadowView.layer.bounds).cgPath
            self.sendSubview(toBack: borderShadowView)
        }
        
        if let arrowShadowView: TriangleView = self._arrowShadowView {
            let arrowShadowBase: CGFloat = type(of: self)._arrowShadowBase()
            let arrowShadowHeight: CGFloat = type(of: self)._arrowShadowHeight()
            var arrowShadowX: CGFloat = 0
            var arrowShadowY: CGFloat = 0
            
            switch arrowDirection {
            case UIPopoverArrowDirection.up:
                arrowShadowX = ((width - arrowShadowBase) / 2) + arrowOffset
                arrowShadowY = arrowY - 2
            case UIPopoverArrowDirection.down:
                arrowShadowX = ((width - arrowShadowBase) / 2) + arrowOffset
                arrowShadowY = arrowY - 1
            case UIPopoverArrowDirection.left:
                arrowShadowX = arrowX - 2
                arrowShadowY = ((height - arrowShadowHeight) / 2) + arrowOffset
            case UIPopoverArrowDirection.right:
                arrowShadowX = arrowX - 1
                arrowShadowY = ((height - arrowShadowHeight) / 2) + arrowOffset
            default:
                break
            }
            
            arrowShadowView.origin = CGPoint(x: arrowShadowX, y: arrowShadowY)
            arrowShadowView.transform = rotation
            arrowShadowView.layer.shadowPath = arrowShadowView.trianglePath()
            arrowShadowView.isHidden = arrowShouldBeHidden
            self.sendSubview(toBack: arrowShadowView)
        }
        
        // This hack is needed to get rid of the default dimming/blur-shadow
        let hideShadowImageViews: Bool = !(type(of: self).dimsBackground)
        self.superview?.superview?.subviews
            .filter({ !($0 is RAPopoverBackgroundView || $0 is PopoverContainerView) })
            .reduce([], { $0 + $1.subviews })
            .filter({ !($0 is RAPopoverBackgroundView || $0 is PopoverContainerView) })
            .forEach({ ($0 as? UIImageView)?.isHidden = hideShadowImageViews })
    }
}


// MARK: Add Subviews
private extension RAPopoverBackgroundView {
    func _addSubviews() {
        self.addSubview(self._arrowView)
        self.addSubview(self._borderView)
        
        if type(of: self).displaysBorderShadow {
            let borderShadowView: UIView = self._createBorderShadowView()
            self._borderShadowView = borderShadowView
            self.addSubview(borderShadowView)
            
            let arrowShadowView: TriangleView = self._createArrowShadowView()
            self._arrowShadowView = arrowShadowView
            self.addSubview(arrowShadowView)
        }
    }
}
