//
//  NSObject (Associations).swift
//  TastyTomato
//
//  Created by Jan Nash on 3/27/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import Foundation
import ObjectiveC


// MARK: // Internal
extension NSObject {
    enum AssociationType_: Int {
        case strongly
        case weakly
    }
    
    func associate_(_ value: Any?, _ associationType: NSObject.AssociationType_, by key: inout Void?) {
        self._associate(value, associationType, by: &key)
    }
    
    func associatedValue_<T>(for key: inout Void?) -> T? {
        return self._associatedValue(for: &key)
    }
}


// MARK: // Private
private extension NSObject {
    func _associate(_ value: Any?, _ associationType: NSObject.AssociationType_, by key: inout Void?) {
        switch associationType {
        case .strongly:
            objc_setAssociatedObject(self, &key, value, .OBJC_ASSOCIATION_RETAIN);
        case .weakly:
            objc_setAssociatedObject(self, &key, value, .OBJC_ASSOCIATION_ASSIGN);
        }
    }
    
    func _associatedValue<T>(for key: inout Void?) -> T? {
        return objc_getAssociatedObject(self, &key) as? T
    }
}
