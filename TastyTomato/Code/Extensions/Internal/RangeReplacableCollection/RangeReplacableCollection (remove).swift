//
//  RangeReplacableCollection (remove).swift
//  TastyTomato
//
//  Created by Jan Nash on 3/27/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import Foundation


// MARK: // Internal
extension RangeReplaceableCollection where Iterator.Element: Equatable {
    mutating func remove_(_ object : Iterator.Element?) {
        if object != nil {
            if let index = self.index(of: object!) {
                self.remove(at: index)
            }
        }
    }
}
