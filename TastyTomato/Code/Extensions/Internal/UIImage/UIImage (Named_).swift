//
//  UIImage (Named_).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/19/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Image With Suffix
extension UIImage {
    class func imageNamed_(_ name: String, inBundle bundle: Bundle = BundleHelper_.TastyTomatoBundle) -> Self {
        return self._imageNamed(name, inBundle: bundle)
    }
    
    class func suffixed_(_ suffix: String) -> Self {
        return self._suffixed(suffix)
    }
}


// MARK: // Private
// MARK: Image With Suffix Implementation
private extension UIImage {
    static func _imageNamed(_ name: String, inBundle bundle: Bundle) -> Self {
        let result = self.`init`(named:`in`:compatibleWith:)(
            named: name,
            in: bundle,
            compatibleWith: nil
        )
        
        if result == nil {
            fatalError("\(self.classForCoder()) named \(name) could not be found in bundle \(bundle)!")
        }
        
        return result!
    }
    
    static func _suffixed(_ suffix: String) -> Self {
        let className: String = "\(self.classForCoder())"
        let combinedString: String = "\(className)-\(suffix)"
        
        return self.imageNamed_(combinedString)
    }
}
