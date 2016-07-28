//
//  Grid.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Interface
extension Grid {
    var frame: CGRect {
        get {
            return self._frame
        }
        set(newFrame) {
            self._frame = newFrame
        }
    }
    
    var hUnits: Int {
        return self._hUnits
    }
    
    var vUnits: Int {
        return self._vUnits
    }
    
//    var unitWidth: CGFloat {
//        return self._unitWidth
//    }
}


// MARK: Class Declaration
class Grid: AnyObject {
    init(frame: CGRect, hUnits: Int, vUnits: Int) {
        self._frame = frame
        self._hUnits = hUnits
        self._vUnits = vUnits
    }
    
    // Private Constant Stored Properties
    private let _unitWidth: CGFloat = 10
    
    // Private Variable Stored Properties
    private var _frame: CGRect
    private var _hUnits: Int
    private var _vUnits: Int
}


// MARK: // Private
// MARK: Computed Variables
private extension Grid {
//    private var _unitWidth: CGFloat {
//        return self.
//    }
}
