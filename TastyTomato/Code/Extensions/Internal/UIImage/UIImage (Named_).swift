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
    class func imageNamed_(name: String, inBundle bundle: NSBundle = _TastyTomatoBundle_) -> Self {
        return self._fromImageNamed(name, inBundle: bundle)
    }
    
    class func suffixed_(suffix: String) -> Self {
        return self._suffixed(suffix)
    }
}


// MARK: // Private
// MARK: Image With Suffix Implementation
private extension UIImage {
    static func _fromImageNamed(name: String, inBundle bundle: NSBundle) -> Self {
        let result = self.init(
            named: name,
            inBundle: bundle,
            compatibleWithTraitCollection: nil
        )
        
        if result == nil {
            fatalError("\(self.classForCoder()) named \(name) could not be found in bundle \(bundle)!")
        }
        
        return result!
    }
    
    static func _suffixed(suffix: String) -> Self {
        let className: String = "\(self.classForCoder())"
        let combinedString: String = "\(className)-\(suffix)"
        
        return self.imageNamed_(combinedString)
    }
}
