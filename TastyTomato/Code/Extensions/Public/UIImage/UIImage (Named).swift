//
//  UIImage (Named).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/25/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIImage {
    public class func imageNamed(_ name: String, inBundle bundle: Bundle = Bundle.main) -> Self {
        return self.imageNamed_(name, inBundle: bundle)
    }
}
