//
//  Collection (SafeSubscript).swift
//  TastyTomato
//
//  Created by Jan Nash on 6/23/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import Foundation


// MARK: // Internal
extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Generator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
