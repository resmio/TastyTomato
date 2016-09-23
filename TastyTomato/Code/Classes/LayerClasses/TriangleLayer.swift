//
//  TriangleLayer.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public 
// MARK: Class Declaration
public class TriangleLayer: CAShapeLayer {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("TriangleLayer does not support NSCoding")
    }
    
    // Init
    public init(baseWidth: CGFloat, height: CGFloat) {
        super.init()
        
        let trianglePath: UIBezierPath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 0, y: height))
        trianglePath.addLineToPoint(CGPoint(x: baseWidth / 2, y: 0))
        trianglePath.addLineToPoint(CGPoint(x: baseWidth, y: height))
        trianglePath.closePath()
        
        self.frame = CGRect(x: 0, y: 0, width: baseWidth, height: height)
        self.path = trianglePath.CGPath
    }
}
