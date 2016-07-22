//
//  UIImage (Named_).swift
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
        let className: String = "\(self.classForCoder())"
        let combinedString: String = "\(className)-\(name)"
        
        let result = self.init(
            named: combinedString,
            inBundle: _TastyTomatoBundle_,
            compatibleWithTraitCollection: nil
        )
        
        if result == nil {
            fatalError("\(className) named \(combinedString) could not be found!")
        }
        
        return result!
    }
}
