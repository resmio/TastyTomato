//
//  NSL_.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/29/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public func NSL_(key: String) -> String {
    return NSLocalizedString(
        key,
        tableName: nil,
        bundle: _TastyTomatoBundle_,
        value: "",
        comment: ""
    )
}
