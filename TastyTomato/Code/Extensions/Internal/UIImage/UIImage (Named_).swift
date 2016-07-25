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
    class func fromImageNamed_(name: String) -> Self {
        return self._fromImageNamed(name)
    }
    
    class func suffixed_(suffix: String) -> Self {
        return self._suffixed(suffix)
    }
}


// MARK: // Private
// MARK: Image With Suffix Implementation
private extension UIImage {
    static func _fromImageNamed(name: String) -> Self {
        let result = self.init(
            named: name,
            inBundle: _TastyTomatoBundle_,
            compatibleWithTraitCollection: nil
        )
        
        if result == nil {
            fatalError("\(self.classForCoder()) named \(name) could not be found!")
        }
        
        return result!
    }
    
    static func _suffixed(suffix: String) -> Self {
        let className: String = "\(self.classForCoder())"
        let combinedString: String = "\(className)-\(suffix)"
        
        return self.fromImageNamed_(combinedString)
    }
}
