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
        return self._trianglePath()
    }
}

// MARK: Class Declaration
open class TriangleView: UIView {
    // Convenience Init
    convenience init(baseWidth: CGFloat) {
        let height: CGFloat = (baseWidth / 2) * sqrt(3.0)
        let frame: CGRect = CGRect(x: 0, y: 0, width: baseWidth, height: height)
        self.init(frame: frame)
        self._addTriangleMaskLayer()
    }
}


// MARK: // Private
// MARK: Implementation
private extension TriangleView {
    func _addTriangleMaskLayer() {
        self.layer.mask = TriangleLayer(baseWidth: self.width, height: self.height)
    }
    
    func _trianglePath() -> CGPath {
        let triangleLayer: CAShapeLayer = self.layer.mask as! CAShapeLayer
        return triangleLayer.path!
    }
}
