//
//  UIImage (Named).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/25/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIImage {
    public class func imageNamed(name: String, inBundle bundle: NSBundle = NSBundle.mainBundle()) -> Self {
        return self.imageNamed_(name, inBundle: bundle)
    }
}
