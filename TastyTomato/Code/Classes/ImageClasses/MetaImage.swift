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
        fatalError("\(type(of: self)) does not support NSCoding")
    }
    
    // Internalized Initializers
    internal override init() {
        super.init()
    }
    
    internal override init?(data: Data) {
        super.init(data: data)
    }
    
    internal override init?(data: Data, scale: CGFloat) {
        super.init(data: data, scale: scale)
    }
    
    internal override init?(contentsOfFile path: String) {
        super.init(contentsOfFile: path)
    }
    
    internal override init(cgImage: CGImage) {
        super.init(cgImage: cgImage)
    }
    
    internal override init(cgImage: CGImage, scale: CGFloat, orientation: UIImageOrientation) {
        super.init(cgImage: cgImage, scale: scale, orientation: orientation)
    }
    
    internal override init(ciImage: CoreImage.CIImage) {
        super.init(ciImage: ciImage)
    }
    
    internal override init(ciImage: CoreImage.CIImage, scale: CGFloat, orientation: UIImageOrientation) {
        super.init(ciImage: ciImage, scale: scale, orientation: orientation)
    }
}
