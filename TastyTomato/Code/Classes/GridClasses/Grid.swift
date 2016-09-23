//
//  Grid.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Global
public extension Grid {
    public static var GlobalGrid: Grid {
        return self._GlobalGrid
    }
    
    public static var globalUnitSideLength: CGFloat {
        return self.GlobalGrid.unitSideLength
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
    
    // ReadOnly
    public var columns: Int {
        return self._columns
    }
    
    public var unitSideLength: CGFloat {
        return self._unitSideLength
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
    private var _columns: Int = 16
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
    private var _unitSideLength: CGFloat {
        return self._frame.width / self.columns
    }
}
