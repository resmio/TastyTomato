//
//  GridLayer.swift
//  TastyTomato
//
//  Created by Jan Nash on 3/27/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Interface
public extension GridLayer {
    // MARK: Location
    public typealias Location = (row: UInt, column: UInt)
    
    public enum Subdivision: CGFloat {
        case none = 1.0
        case half = 0.5
        case quarter = 0.25
        case eighth = 0.125
    }
    
    public var numOfRows: UInt {
        get {
            return self._numOfRows
        }
        set(newNumOfRows) {
            self._numOfRows = newNumOfRows
        }
    }
    
    public var numOfColumns: UInt {
        get {
            return self._numOfColumns
        }
        set(newNumOfColumns) {
            self._numOfColumns = newNumOfColumns
        }
    }

    public var subdivision: GridLayer.Subdivision {
        get {
            return self._subdivision
        }
        set(newSubdivision) {
            self._subdivision = newSubdivision
        }
    }
    
    public var gridIsShown: Bool {
        get {
            return self._gridIsShown
        }
        set(newGridIsShown) {
            self._gridIsShown = newGridIsShown
        }
    }
    
    public var borderIsShownWhenGridIsInset: Bool {
        get {
            return self._borderIsShownWhenGridIsInset
        }
        set(newBorderIsShownWhenGridIsInset) {
            self._borderIsShownWhenGridIsInset = newBorderIsShownWhenGridIsInset
        }
    }
    
    public var lineWidth: CGFloat {
        get {
            return self._lineWidth
        }
        set(newLineWidth) {
            self._lineWidth = newLineWidth
        }
    }
    
    public var gridInsetFactor: CGFloat {
        get {
            return self._gridInsetFactor
        }
        set(newGridInsetFactor) {
            self._gridInsetFactor = newGridInsetFactor
        }
    }
    
    public var gridLineOverlapFactor: CGFloat {
        get {
            return self._gridLineOverlapFactor
        }
        set(newGridLineOverlapFactor) {
            self._gridLineOverlapFactor = newGridLineOverlapFactor
        }
    }

    public func point(for location: GridLayer.Location) -> CGPoint {
        return self._point(for: location)
    }

    public func location(nearestTo point: CGPoint) -> GridLayer.Location {
        return self._location(nearestTo: point)
    }
}


// MARK: Class Declaration
public class GridLayer: CALayer {
    // Private Variables
    fileprivate var _borderLayer: BorderLayer?
    fileprivate var _lineLayers: [LineLayer] = []
    
    fileprivate var __subdivision: GridLayer.Subdivision = .none
    fileprivate var __gridIsShown: Bool = false
    fileprivate var __borderIsShownWhenGridIsInset: Bool = true
    fileprivate var __lineWidth: CGFloat = 1
    fileprivate var __gridInsetFactor: CGFloat = 0.6
    fileprivate var __gridLineOverlapFactor: CGFloat = 0.4
    
    fileprivate var __numOfRows: UInt = 8
    fileprivate var __numOfColumns: UInt = 8
}


// MARK: // Private
// MARK: Computed Properties
private extension GridLayer {
    // Interface Backing
    var _numOfRows: UInt {
        get {
            return self.__numOfRows
        }
        set(newNumOfRows) {
            guard newNumOfRows != self.__numOfRows else { return }
            if self.gridIsShown {
                self._updateRowLineLayers(
                    oldNumOfRows: self.__numOfRows,
                    newNumOfRows: newNumOfRows
                )
            }
            self.__numOfRows = newNumOfRows
        }
    }
    
    var _numOfColumns: UInt {
        get {
            return self.__numOfColumns
        }
        set(newNumOfColumns) {
            guard newNumOfColumns != self.__numOfColumns else { return }
            if self.gridIsShown {
                self._updateColumnLineLayers(
                    oldNumOfColumns: self.__numOfColumns,
                    newNumOfColumns: newNumOfColumns
                )
            }
            self.__numOfColumns = newNumOfColumns
        }
    }
    
    var _subdivision: GridLayer.Subdivision {
        get {
            return self.__subdivision
        }
        set(newSubdivision) {
            guard newSubdivision != self.__subdivision else { return }
            if self.gridIsShown {
                self._updateLineLayers(
                    oldSubdivision: self.__subdivision,
                    newSubdivision: newSubdivision
                )
            }
            self.__subdivision = newSubdivision
        }
    }
    
    var _gridIsShown: Bool {
        get {
            return self.__gridIsShown
        }
        set(newGridIsShown) {
            guard newGridIsShown != self.__gridIsShown else { return }
            self.__gridIsShown = newGridIsShown
            newGridIsShown ? self._addLineLayers() : self._removeLineLayers()
        }
    }
    
    var _borderIsShownWhenGridIsInset: Bool {
        get {
            return self._borderIsShownWhenGridIsInset
        }
        set(newBorderIsShownWhenGridIsInset) {
            guard newBorderIsShownWhenGridIsInset != self.__borderIsShownWhenGridIsInset else { return }
            self._borderIsShownWhenGridIsInset = newBorderIsShownWhenGridIsInset
            self._updateBorderLayer()
        }
    }
    
    var _lineWidth: CGFloat {
        get {
            return self.__lineWidth
        }
        set(newLineWidth) {
            guard newLineWidth != self.__lineWidth else { return }
            self._lineWidth = newLineWidth
            self._updateLineWidths()
        }
    }
    
    var _gridInsetFactor: CGFloat {
        get {
            return self.__gridInsetFactor
        }
        set(newGridInsetFactor) {
            self.__gridInsetFactor = newGridInsetFactor
        }
    }
    
    var _gridLineOverlapFactor: CGFloat {
        get {
            return self.__gridLineOverlapFactor
        }
        set(newGridLineOverlapFactor) {
            self.__gridLineOverlapFactor = newGridLineOverlapFactor
        }
    }
    
    // Helpers
    var _zeroedNumOfColumns: Int {
        return Int(self.__numOfColumns - 1)
    }
    
    var _zeroedNumOfRows: Int {
        return Int(self.__numOfRows - 1)
    }
    
    // Private Helpers
    private func _updateLineWidths() {
        self._borderLayer?.borderWidth = self.lineWidth
        for line in self._lineLayers {
            line.lineWidth = self.lineWidth
        }
    }
    
    private func _updateBorderLayer() {
        if self.borderIsShownWhenGridIsInset && self.gridInsetFactor != 0 {
            self._addBorderLayer()
        } else {
            self._removeBorderLayer()
        }
    }
}
