//
//  BorderLayer.swift
//  TastyTomato
//
//  Created by Jan Nash on 3/26/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Interface
public extension BorderLayer {
    public var borderEdgeInsets: UIEdgeInsets {
        get {
            return self._borderEdgeInsets
        }
        set(newBorderEdgeInsets) {
            self._borderEdgeInsets = newBorderEdgeInsets
        }
    }
}


// MARK: Class Declaration
public class BorderLayer: CAShapeLayer {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("BorderLayer does not support NSCoding")
    }
    
    // Override Inits
    public override init() {
        super.init()
        self.lineWidth = 1
        self.strokeColor = UIColor.black.cgColor
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // Private Variables
    fileprivate var __borderEdgeInsets: UIEdgeInsets = .zero
}


// MARK: Unavailability Overrides
extension BorderLayer {
    public override var backgroundColor: CGColor? {
        get { return nil }
        set { fatalError() }
    }
    
    @available(*, unavailable)
    public override var borderColor: CGColor? {
        get { return nil }
        set { fatalError() }
    }
    
    @available(*, unavailable)
    public override var fillColor: CGColor? {
        get { return nil }
        set { fatalError() }
    }
    
    @available(*, unavailable)
    public convenience init(path p: UIBezierPath) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(rect r: CGRect) { fatalError() }
}


// MARK: Frame Override
extension BorderLayer {
    public override var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            guard newFrame != super.frame else { return }
            super.frame = newFrame
            self.path = self._createPath()
        }
    }
}


// MARK: // Private
// MARK: BorderInset
private extension BorderLayer {
    var _borderEdgeInsets: UIEdgeInsets {
        get {
            return self.__borderEdgeInsets
        }
        set(newBorderEdgeInsets) {
            guard newBorderEdgeInsets != self.__borderEdgeInsets else { return }
            self.__borderEdgeInsets = newBorderEdgeInsets
            self.path = self._createPath()
        }
    }
}


// MARK: Create Path
private extension BorderLayer {
    func _createPath() -> CGPath {
        let size: CGSize = self.frame.size
        let insets: UIEdgeInsets = self.borderEdgeInsets
        let x: CGFloat = insets.left
        let y: CGFloat = insets.top
        let width: CGFloat = size.width - (x + insets.right)
        let height: CGFloat = size.height - (y + insets.bottom)
        let pathFrame: CGRect = CGRect(x: x, y: y, width: width, height: height)
        return CGPath(rect: pathFrame, transform: nil)
    }
}
