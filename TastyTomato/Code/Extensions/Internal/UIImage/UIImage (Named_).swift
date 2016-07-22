//
//  UIImage (Init).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/19/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Image With Name
extension UIImage {
    class func named_(name: String) -> Self {
        let bundle: NSBundle = NSBundle(forClass: _BundleHelper.self)
        let combinedString: String = "\(self.classForCoder())-\(name)"
        let result = self.init(named: combinedString, inBundle: bundle, compatibleWithTraitCollection: nil)
        if result == nil {
            fatalError("\(self.classForCoder()) named \(combinedString) could not be found!")
        }
        return result!
    }
}


// MARK: // Private
// MARK: Helper Class For Bundle
private class _BundleHelper {}
