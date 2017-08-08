//
//  Optional (IsNilOrEmpty).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/31/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import Foundation


// MARK: // Internal
// MARK: Optional<String>
extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let .some(wrapped):
            return wrapped.isEmpty
        case .none:
            return true
        }
    }
}


// MARK: Optional<Collection>
extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let .some(wrapped):
            return wrapped.isEmpty
        case .none:
            return true
        }
    }
}
