//
//  TriangleView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 09.08.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
public extension TriangleView {
    public func trianglePath() -> CGPath {
        return (self.layer.mask as! CAShapeLayer).path!
    }
}

// MARK: Class Declaration
public class TriangleView: UIView {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Public Init
    public init(baseWidth: CGFloat) {
        let height: CGFloat = (baseWidth / 2) * sqrt(3.0)
        let frame: CGRect = CGRect(x: 0, y: 0, width: baseWidth, height: height)
        super.init(frame: frame)
        self._init()
    }
    
    // Common Init
    private func _init() {
        self.layer.mask = TriangleLayer(baseWidth: self.width, height: self.height)
    }
}
