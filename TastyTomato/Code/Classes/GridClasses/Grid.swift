//
//  Grid.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Static Instances
public extension Grid {
    public static var GlobalGrid: Grid {
        return self._GlobalGrid
    }
}


// MARK: Interface
public extension Grid {
    // ReadWrite
    public var frame: CGRect {
        get {
            return self._frame
        }
        set(newFrame) {
            self._frame = newFrame
        }
    }
    
    public var unitSideLength: CGFloat {
        get {
            return self._unitSideLength
        }
        set(newUnitSideLength) {
            self._unitSideLength = newUnitSideLength
        }
    }
    
    // ReadOnly
    public var hUnits: CGFloat {
        return self._hUnits
    }
    
    public var vUnits: CGFloat {
        return self._vUnits
    }
}


// MARK: Class Declaration
public class Grid: AnyObject {
    public init(frame: CGRect) {
        self._frame = frame
    }
    
    // Private Static Variable Properties
    private static var __GlobalGrid: Grid?
    
    // Private Variable Stored Properties
    private var _frame: CGRect
    private var _unitSideLength: CGFloat = 10
}


// MARK: // Private
// MARK: Computed Static Variables
private extension Grid {
    private static var _GlobalGrid: Grid {
        if self.__GlobalGrid == nil {
            let frame: CGRect = UIScreen.mainScreen().bounds
            self.__GlobalGrid = Grid(frame: frame)
        }
        return self.__GlobalGrid!
    }
}


// MARK: Computed Variables
private extension Grid {
    private var _hUnits: CGFloat {
        return self.frame.width / self._unitSideLength
    }
    
    private var _vUnits: CGFloat {
        return self.frame.height / self._unitSideLength
    }
}
