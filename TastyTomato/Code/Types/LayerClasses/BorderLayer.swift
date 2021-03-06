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
    var borderEdgeInsets: UIEdgeInsets {
        get { return self._borderEdgeInsets }
        set { self._borderEdgeInsets = newValue }
    }
}


// MARK: Class Declaration
public class BorderLayer: CAShapeLayer {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Inits
    public override init() {
        super.init()
        self._init()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // Common Init
    private func _init() {
        self.lineWidth = 1
        self.strokeColor = UIColor.black.cgColor
    }
    
    // Private Variables
    private var __borderEdgeInsets: UIEdgeInsets = .zero
    
    
    // MARK: Overrides
    public override var frame: CGRect {
        get { return self._frame }
        set { self._frame = newValue }
    }
    
    public override func action(forKey event: String) -> CAAction? {
        return nil
    }
    
    // MARK: Unavailability Overrides
    @available(*, unavailable)
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
}


// MARK: Convenience Init Unavailability Overrides
extension BorderLayer {
    @available(*, unavailable)
    public convenience init(path p: UIBezierPath) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(rect r: CGRect) { fatalError() }
}


// MARK: // Private
// MARK: BorderInset
private extension BorderLayer {
    var _borderEdgeInsets: UIEdgeInsets {
        get { return self.__borderEdgeInsets }
        set(newBorderEdgeInsets) {
            guard newBorderEdgeInsets != self.__borderEdgeInsets else { return }
            self.__borderEdgeInsets = newBorderEdgeInsets
            self.path = self._createPath()
        }
    }
}


// MARK: Override Implementations
private extension BorderLayer {
    var _frame: CGRect {
        get { return super.frame }
        set(newFrame) {
            guard newFrame != super.frame else { return }
            super.frame = newFrame
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
