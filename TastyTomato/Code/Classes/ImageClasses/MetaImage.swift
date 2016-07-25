//
//  MetaImage.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/22/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation
import CoreGraphics


// MARK: // Public
// MARK: Class Declaration
public class MetaImage: UIImage {
    // Required Initializer
    required public init?(coder aDecoder: NSCoder) {
        super.init()
        fatalError("\(self.dynamicType) does not implement NSCoding")
    }
    
    // Internalized Initializers
    internal override init() {
        super.init()
    }
    
    internal override init?(data: NSData) {
        super.init(data: data)
    }
    
    internal override init?(data: NSData, scale: CGFloat) {
        super.init(data: data, scale: scale)
    }
    
    internal override init?(contentsOfFile path: String) {
        super.init(contentsOfFile: path)
    }
    
    internal override init(CGImage cgImage: CGImageRef) {
        super.init(CGImage: cgImage)
    }
    
    internal override init(CGImage cgImage: CGImageRef, scale: CGFloat, orientation: UIImageOrientation) {
        super.init(CGImage: cgImage, scale: scale, orientation: orientation)
    }
    
    internal override init(CIImage ciImage: CoreImage.CIImage) {
        super.init(CIImage: ciImage)
    }
    
    internal override init(CIImage ciImage: CoreImage.CIImage, scale: CGFloat, orientation: UIImageOrientation) {
        super.init(CIImage: ciImage, scale: scale, orientation: orientation)
    }
}
