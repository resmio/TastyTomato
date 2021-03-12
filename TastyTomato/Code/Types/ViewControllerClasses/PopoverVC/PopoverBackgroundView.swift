//
//  PopoverBackgroundView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 09.08.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit
import SignificantSpices


// MARK: // Internal
// MARK: Interface / Class Declaration
public class PopoverBackgroundView: UIPopoverBackgroundView {
    // Interface
    // (These need to be inside the class declaration, so they are properly overridable)
    class var backgroundColor: UIColor {
        get { return self._backgroundColor }
        set { self._backgroundColor = newValue }
    }
    
    class var dimsBackground: Bool {
        get { return self._dimsBackground }
        set { self._dimsBackground = newValue }
    }
    
    class var displaysBorderShadow: Bool {
        get { return self._displaysBorderShadow }
        set { self._displaysBorderShadow = newValue }
    }
    
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    // Common Init
    private func _init() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self._addSubviews()
    }
    
    // Private Static Constants
    private static let _defaultArrowBase: CGFloat = 18
    private static let _defaultContentViewInsets: UIEdgeInsets = .zero
    
    // Private Static Variables
    private static var _backgroundColor: UIColor = .white
    private static var _dimsBackground: Bool = true
    private static var _displaysBorderShadow: Bool = true
    
    // Private Lazy Variables
    private lazy var _borderView: UIView = self._createBorderView()
    private lazy var _arrowView: TriangleView = self._createArrowView()
    private lazy var _borderShadowView: ALO<UIView> = ALO({ [unowned self] in self._createBorderShadowView() })
    private lazy var _arrowShadowView: ALO<TriangleView> = ALO({ [unowned self] in self._createArrowShadowView() })
    
    // Private Variables
    private var __arrowOffset: CGFloat = 0
    private var __arrowDirection: UIPopoverArrowDirection = .any
    
    
    // Static Overrides
    override public static func arrowBase() -> CGFloat {
        return self._defaultArrowBase
    }
    
    override public static func arrowHeight() -> CGFloat {
        return self._arrowHeight()
    }
    
    override public static func contentViewInsets() -> UIEdgeInsets {
        return self._defaultContentViewInsets
    }
    
    override public class var wantsDefaultContentAppearance: Bool {
        return false
    }
    
    // Layout Overrides
    override public func layoutSubviews() {
        self._layoutSubviews()
    }
    
    override public var arrowOffset: CGFloat {
        get { return self._arrowOffset }
        set { self._arrowOffset = newValue }
    }
    
    override public var arrowDirection: UIPopoverArrowDirection {
        get { return self._arrowDirection }
        set { self._arrowDirection = newValue }
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension PopoverBackgroundView {
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
private extension PopoverBackgroundView {
    var _arrowOffset: CGFloat {
        get { return self.__arrowOffset }
        set(newArrowOffset) {
            guard newArrowOffset != self.__arrowOffset else { return }
            self.__arrowOffset = newArrowOffset
            self.setNeedsLayout()
        }
    }
    
    var _arrowDirection: UIPopoverArrowDirection {
        get { return self.__arrowDirection }
        set(newArrowDirection) {
            guard newArrowDirection != self.__arrowDirection else { return }
            self.__arrowDirection = newArrowDirection
            self.setNeedsLayout()
        }
    }
}


// MARK: Arrow Shadow Helpers
private extension PopoverBackgroundView {
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
private extension PopoverBackgroundView {
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
        
        if let borderShadowView: UIView = self._borderShadowView¿ {
            borderShadowView.frame = CGRect(x: borderX, y: borderY, width: borderWidth, height: borderHeight)
            borderShadowView.layer.shadowPath = UIBezierPath(rect: borderShadowView.layer.bounds).cgPath
            self.sendSubviewToBack(borderShadowView)
        }
        
        if let arrowShadowView: TriangleView = self._arrowShadowView¿ {
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
            self.sendSubviewToBack(arrowShadowView)
        }
        
        // This hack is needed to get rid of the default dimming/blur-shadow
        let hideShadowImageViews: Bool = !(type(of: self).dimsBackground)
        self.superview?.superview?.subviews
            .filter(self._isNotPopoverBackgroundOrContainerView)
            .reduce([], { $0 + $1.subviews.filter(self._isNotPopoverBackgroundOrContainerView) })
            .forEach({ ($0 as? UIImageView)?.isHidden = hideShadowImageViews })
    }
    
    private func _isNotPopoverBackgroundOrContainerView(_ view: UIView) -> Bool {
        return !(view is PopoverBackgroundView || view is PopoverContainerView)
    }
}


// MARK: Add Subviews
private extension PopoverBackgroundView {
    func _addSubviews() {
        self.addSubview(self._arrowView)
        self.addSubview(self._borderView)
        
        if type(of: self).displaysBorderShadow {
            self.addSubview(self._borderShadowView¡)
            self.addSubview(self._arrowShadowView¡)
        }
    }
}
