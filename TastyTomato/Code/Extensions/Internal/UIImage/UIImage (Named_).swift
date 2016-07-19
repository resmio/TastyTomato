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
        let combinedString: String = "\(self.dynamicType)-\(name)"
        let result = self.init(named: combinedString)
        if result == nil {
            fatalError("\(self.dynamicType) named \(combinedString) could not be found!")
        }
        return result!
    }
}
