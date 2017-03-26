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


// MARK: Class Declaration
class BorderLayer: CAShapeLayer {
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
    public convenience init(frame: CGRect) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(size: CGSize) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(path p: UIBezierPath) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(rect r: CGRect) { fatalError() }
}
