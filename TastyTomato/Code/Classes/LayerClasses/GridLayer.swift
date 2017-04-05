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
        
        // This list MUST be sorted by descending rawValue
        // If it isn't, bad things will happen in the code below!
        fileprivate static let _divisions: [GridLayer.Subdivision] = [.none, .half, .quarter, .eighth]
    }
    
    // ReadWrite
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
    
    public var borderIsShown: Bool {
        get {
            return self._borderIsShown
        }
        set(newBorderIsShown) {
            self._borderIsShown = newBorderIsShown
        }
    }
    
    public var rowHeight: CGFloat {
        get {
            return self._rowHeight
        }
        set(newRowWidth) {
            self._rowHeight = newRowWidth
        }
    }
    
    public var columnWidth: CGFloat {
        get {
            return self._columnWidth
        }
        set(newColumnWidth) {
            self._columnWidth = newColumnWidth
        }
    }
    
    public var borderLineColor: CGColor {
        get {
            return self._borderLineColor
        }
        set(newBorderLineColor) {
            self._borderLineColor = newBorderLineColor
        }
    }
    
    public var mainGridLineColor: CGColor {
        get {
            return self._mainGridLineColor
        }
        set(newMainGridLineColor) {
            self._mainGridLineColor = newMainGridLineColor
        }
    }
    
    public var subGridLineColor: CGColor {
        get {
            return self._subGridLineColor
        }
        set(newSubGridLineColor) {
            self._subGridLineColor = newSubGridLineColor
        }
    }
    
    public var borderLineWidth: CGFloat {
        get {
            return self._borderLineWidth
        }
        set(newBorderLineWidth) {
            self._borderLineWidth = newBorderLineWidth
        }
    }
    
    public var gridLineWidth: CGFloat {
        get {
            return self._gridLineWidth
        }
        set(newGridLineWidth) {
            self._gridLineWidth = newGridLineWidth
        }
    }
    
    public var borderDashPattern: [CGFloat] {
        get {
            return self._borderDashPattern as! [CGFloat]
        }
        set(newBorderDashPattern) {
            self._borderDashPattern = newBorderDashPattern as [NSNumber]
        }
    }
    
    public var gridDashPattern: [CGFloat] {
        get {
            return self._gridDashPattern as! [CGFloat]
        }
        set(newGridDashPattern) {
            self._gridDashPattern = newGridDashPattern as [NSNumber]
        }
    }
    
    public var borderEdgeInsets: UIEdgeInsets {
        get {
            return self._borderEdgeInsets
        }
        set(newBorderEdgeInsets) {
            self._borderEdgeInsets = newBorderEdgeInsets
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
    
    public func point(for slotIndex: UInt) -> CGPoint {
        return self._point(for: slotIndex)
    }
}


// MARK: Class Declaration
public class GridLayer: CALayer {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        fatalError("GridLayer does not support NSCoding")
    }
    
    // Override Inits
    public override init() {
        super.init()
        self._createOrDestroyBorderLayer()
        self._updateLineLayers()
        self._sizeFrame()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // Private Variables
    fileprivate var _borderLayer: BorderLayer?
    fileprivate var _lineLayers: [LineLayer] = []
    
    fileprivate var __subdivision: GridLayer.Subdivision = .none
    fileprivate var __gridIsShown: Bool = false
    fileprivate var __borderIsShown: Bool = true
    fileprivate var __rowHeight: CGFloat = 150
    fileprivate var __columnWidth: CGFloat = 150
    fileprivate var __borderLineColor: CGColor = UIColor.Gray999999().withAlpha(0.8).cgColor
    fileprivate var __mainGridLineColor: CGColor = UIColor.Gray999999().withAlpha(0.8).cgColor
    fileprivate var __subGridLineColor: CGColor = UIColor.Gray999999().withAlpha(0.4).cgColor
    fileprivate var __borderLineWidth: CGFloat = 1
    fileprivate var __gridLineWidth: CGFloat = 1
    fileprivate var __borderDashPattern: [NSNumber] = []
    fileprivate var __gridDashPattern: [NSNumber] = []
    fileprivate var __borderEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    fileprivate var __gridInsetFactor: CGFloat = 0.6
    fileprivate var __gridLineOverlapFactor: CGFloat = 0.4
    
    fileprivate var __numOfRows: UInt = 8
    fileprivate var __numOfColumns: UInt = 8
    
    
    // MARK: Overrides
    public override func preferredFrameSize() -> CGSize {
        return self._preferredFrameSize()
    }
    
    public override func layoutSublayers() {
        self._layoutSublayers()
    }
    
    public override func action(forKey event: String) -> CAAction? {
        return nil
    }
}


// MARK: // Private
// MARK: Computed Properties
private extension GridLayer {
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
            self._updateColumnLineLengths()
            self._sizeFrame()
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
            self._updateRowLineLengths()
            self._sizeFrame()
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
            self._updateLineLayers()
        }
    }
    
    var _borderIsShown: Bool {
        get {
            return self.__borderIsShown
        }
        set(newBorderIsShown) {
            guard newBorderIsShown != self.__borderIsShown else { return }
            self.__borderIsShown = newBorderIsShown
            self._createOrDestroyBorderLayer()
        }
    }
    
    var _rowHeight: CGFloat {
        get {
            return self.__rowHeight
        }
        set(newRowHeight) {
            guard newRowHeight != self.__rowHeight else { return }
            self.__rowHeight = newRowHeight
            self._updateColumnLineLengths()
            self._sizeFrame()
            self.setNeedsLayout()
        }
    }
    
    var _columnWidth: CGFloat {
        get {
            return self.__columnWidth
        }
        set(newColumnWidth) {
            guard newColumnWidth != self.__columnWidth else { return }
            self.__columnWidth = newColumnWidth
            self._updateRowLineLengths()
            self._sizeFrame()
            self.setNeedsLayout()
        }
    }
    
    var _borderLineColor: CGColor {
        get {
            return self.__borderLineColor
        }
        set(newBorderLineColor) {
            guard newBorderLineColor != self.__borderLineColor else { return }
            self.__borderLineColor = newBorderLineColor
            self._borderLayer?.strokeColor = newBorderLineColor
        }
    }
    
    var _mainGridLineColor: CGColor {
        get {
            return self.__mainGridLineColor
        }
        set(newMainGridLineColor) {
            guard newMainGridLineColor != self.__mainGridLineColor else { return }
            self.__mainGridLineColor = newMainGridLineColor
            self._forEachLine(
                where: { $0._positionIndex.subdivision == .none },
                execute: { $0.strokeColor = newMainGridLineColor }
            )
        }
    }
    
    var _subGridLineColor: CGColor {
        get {
            return self.__subGridLineColor
        }
        set(newSubGridLineColor) {
            guard newSubGridLineColor != self.__subGridLineColor else { return }
            self.__subGridLineColor = newSubGridLineColor
            self._forEachLine(
                where: { $0._positionIndex.subdivision != .none },
                execute: { $0.strokeColor = newSubGridLineColor }
            )
        }
    }
    
    var _borderLineWidth: CGFloat {
        get {
            return self.__borderLineWidth
        }
        set(newBorderLineWidth) {
            guard newBorderLineWidth != self.__borderLineWidth else { return }
            self.__borderLineWidth = newBorderLineWidth
            self._borderLayer?.lineWidth = newBorderLineWidth
        }
    }
    
    var _gridLineWidth: CGFloat {
        get {
            return self.__gridLineWidth
        }
        set(newGridLineWidth) {
            guard newGridLineWidth != self.__gridLineWidth else { return }
            self.__gridLineWidth = newGridLineWidth
            self._updateLineLayers({ $0.lineWidth = newGridLineWidth })
        }
    }
    
    var _borderDashPattern: [NSNumber] {
        get {
            return self.__borderDashPattern
        }
        set(newBorderDashPattern) {
            guard newBorderDashPattern != self.__borderDashPattern else { return }
            self.__borderDashPattern = newBorderDashPattern
            self._borderLayer?.lineDashPattern = newBorderDashPattern
        }
    }
    
    var _gridDashPattern: [NSNumber] {
        get {
            return self.__gridDashPattern
        }
        set(newGridDashPattern) {
            guard newGridDashPattern != self.__gridDashPattern else { return }
            self.__gridDashPattern = newGridDashPattern
            self._updateLineLayers({ $0.lineDashPattern = newGridDashPattern })
        }
    }
    
    var _borderEdgeInsets: UIEdgeInsets {
        get {
            return self.__borderEdgeInsets
        }
        set(newBorderEdgeInsets) {
            guard newBorderEdgeInsets != self.__borderEdgeInsets else { return }
            self.__borderEdgeInsets = newBorderEdgeInsets
            self._borderLayer?.borderEdgeInsets = newBorderEdgeInsets
        }
    }
    
    var _gridInsetFactor: CGFloat {
        get {
            return self.__gridInsetFactor
        }
        set(newGridInsetFactor) {
            guard newGridInsetFactor != self.__gridInsetFactor else { return }
            self.__gridInsetFactor = newGridInsetFactor
        }
    }
    
    var _gridLineOverlapFactor: CGFloat {
        get {
            return self.__gridLineOverlapFactor
        }
        set(newGridLineOverlapFactor) {
            guard newGridLineOverlapFactor != self.__gridLineOverlapFactor else { return }
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
    private func _updateLineLayers(_ block: ((LineLayer) -> Void)) {
        self._lineLayers.forEach(block)
    }
}


// MARK: Override Implementations
private extension GridLayer {
    func _preferredFrameSize() -> CGSize {
        return CGSize(width: self._width(), height: self._height())
    }
    
    func _layoutSublayers() {
        self._lineLayers.forEach(self._updatePosition)
    }
    
    // Helpers
    func _sizeFrame() {
        let frameSize: CGSize = self.preferredFrameSize()
        self.frame.size = frameSize
        self._borderLayer?.frame.size = frameSize
    }
    
    func _width() -> CGFloat {
        return ((2 * self.gridInsetFactor) + self._zeroedNumOfColumns) * self.columnWidth
    }
    
    func _height() -> CGFloat {
        return ((2 * self.gridInsetFactor) + self._zeroedNumOfRows) * self.rowHeight
    }
}


// MARK: Border
private extension GridLayer {
    func _createOrDestroyBorderLayer() {
        if self.borderIsShown && self.gridInsetFactor != 0 {
            self._addBorderLayer()
        } else {
            self._removeBorderLayer()
        }
    }
    
    // Private Helpers
    private func _addBorderLayer() {
        let borderLayer: BorderLayer = BorderLayer()
        borderLayer.lineWidth = self.borderLineWidth
        borderLayer.lineDashPattern = self.borderDashPattern as [NSNumber]
        borderLayer.borderEdgeInsets = self.borderEdgeInsets
        self._borderLayer = borderLayer
        self.addSublayer(borderLayer)
    }
    
    private func _removeBorderLayer() {
        self._borderLayer?.removeFromSuperlayer()
        self._borderLayer = nil
    }
}


// MARK: - LineLayer Extension
// MARK: Virtual Properties
private var _positionIndexKey: Void?
private extension LineLayer {
    var _positionIndex: _PositionIndex {
        get {
            return self.associatedValue_(for: &_positionIndexKey)!
        }
        set(newPositionIndex) {
            self.associate_(newPositionIndex, .strongly, by: &_positionIndexKey)
        }
    }
}


// MARK: - _PositionIndex Struct
// MARK: Struct Declaration
private struct _PositionIndex {
    var value: CGFloat
    var subdivision: GridLayer.Subdivision
}


// MARK: Equatable
extension _PositionIndex: Equatable {}
private func ==(lhs: _PositionIndex, rhs: _PositionIndex) -> Bool {
    return lhs.value == rhs.value
}


// MARK: Hashable
extension _PositionIndex: Hashable {
    var hashValue: Int {
        return self.value.hashValue
    }
}


// MARK: - GridLayer.Subdivision Extension
// MARK: Helper Functions
private extension GridLayer.Subdivision {
    static func _divisions(after: GridLayer.Subdivision, through: GridLayer.Subdivision) -> [GridLayer.Subdivision] {
        return self._divisions.filter({
            $0.rawValue < after.rawValue && $0.rawValue >= through.rawValue
        })
    }
    
    static func _divisions(through: GridLayer.Subdivision) -> [GridLayer.Subdivision] {
        return self._divisions.filter({
            $0.rawValue >= through.rawValue
        })
    }
}


// MARK: Private Typealiases
private typealias _PositionIndexSet = Set<_PositionIndex>
private typealias _PositionIndexSets = (
    rowIndices: _PositionIndexSet,
    columnIndices: _PositionIndexSet
)


// MARK: - GridLayer
// MARK: LineLayers
private extension GridLayer {
    func _updateLineLayers() {
        if self.gridIsShown {
            self._addLineLayers()
        } else {
            self._removeLineLayers()
        }
    }
    
    func _updateRowLineLayers(oldNumOfRows: UInt, newNumOfRows: UInt) {
        if newNumOfRows > oldNumOfRows {
            self._addLines(withOrientation: .horizontal, after: oldNumOfRows, through: newNumOfRows)
        } else if newNumOfRows < oldNumOfRows {
            self._purgeRows(downTo: newNumOfRows)
        }
    }
    
    func _updateColumnLineLayers(oldNumOfColumns: UInt, newNumOfColumns: UInt) {
        if newNumOfColumns > oldNumOfColumns {
            self._addLines(withOrientation: .vertical, after: oldNumOfColumns, through: newNumOfColumns)
        } else if newNumOfColumns < oldNumOfColumns {
            self._purgeColumns(downTo: newNumOfColumns)
        }
    }
    
    func _updateLineLayers(oldSubdivision: GridLayer.Subdivision, newSubdivision: GridLayer.Subdivision) {
        if newSubdivision.rawValue < oldSubdivision.rawValue {
            self._addLines(after: oldSubdivision, through: newSubdivision)
        } else if newSubdivision.rawValue > oldSubdivision.rawValue {
            self._purgeLines(upTo: newSubdivision)
        }
    }
    
    func _updatePosition(for line: LineLayer) {
        line.parallelPosition = self._parallelInset(for: line)
        line.orthogonalPosition = self._orthogonalOffset(for: line)
    }
    
    func _updateRowLineLengths() {
        self._forEachLine(
            where: { $0.orientation == .horizontal },
            execute: { $0.length = self._lengthForRow($0) }
        )
    }
    
    func _updateColumnLineLengths() {
        self._forEachLine(
            where: { $0.orientation == .vertical },
            execute: { $0.length = self._lengthForColumn($0) }
        )
    }
    
    func _forEachLine(where condition: ((LineLayer) -> Bool), execute: (LineLayer) -> Void) {
        self._lineLayers.forEach({
            if condition($0) {
                execute($0)
            }
        })
    }
    
    // Private Helper Functions
    private func _addLineLayers() {
        self._addLines(through: self.subdivision)
    }
    
    private func _removeLineLayers() {
        for lineLayer in self._lineLayers {
            lineLayer.removeFromSuperlayer()
        }
        self._lineLayers = []
    }
    
    private func _addLines(withOrientation orientation: LineLayer.Orientation, after oldNum: UInt, through newNum: UInt) {
        let positionIndexSet: _PositionIndexSet = Set(
            self._positionIndices(
                subdivs: Subdivision._divisions(through: self.subdivision),
                from: CGFloat(oldNum - 1),
                through: CGFloat(newNum - 1)
            )
        )
        
        self._addLines(
            withOrientation: orientation,
            for: positionIndexSet
        )
    }
    
    private func _addLines(after oldSubdivision: GridLayer.Subdivision? = nil, through newSubdivision: GridLayer.Subdivision) {
        var rowIndices: [_PositionIndex] = []
        var columnIndices: [_PositionIndex] = []
        
        for line in self._lineLayers {
            if line.orientation == .horizontal {
                rowIndices.append(line._positionIndex)
            } else /*if line.orientation == .vertical*/ {
                columnIndices.append(line._positionIndex)
            }
        }
        
        var divisionsToAdd: [GridLayer.Subdivision]
        if let oldSubdivision: GridLayer.Subdivision = oldSubdivision {
            divisionsToAdd = GridLayer.Subdivision._divisions(after: oldSubdivision, through: newSubdivision)
        } else {
            divisionsToAdd = GridLayer.Subdivision._divisions(through: newSubdivision)
        }
        
        let newIndices: _PositionIndexSets = self._positionIndexSets(
            subdivs: divisionsToAdd,
            numOfRows: CGFloat(self.numOfRows - 1),
            numOfColumns: CGFloat(self.numOfColumns - 1)
        )
        
        let rowIndicesToAdd: _PositionIndexSet = newIndices.rowIndices.subtracting(rowIndices)
        let columnIndicesToAdd: _PositionIndexSet = newIndices.columnIndices.subtracting(columnIndices)
        
        self._addLines(withOrientation: .horizontal, for: rowIndicesToAdd)
        self._addLines(withOrientation: .vertical, for: columnIndicesToAdd)
    }
    
    private func _purgeRows(downTo numOfRows: UInt) {
        self._purgeLines(where: {
            $0.orientation == .horizontal &&
            $0._positionIndex.value > (numOfRows - 1)
        })
    }
    
    private func _purgeColumns(downTo numOfRows: UInt) {
        self._purgeLines(where: {
            $0.orientation == .vertical &&
            $0._positionIndex.value > (numOfRows - 1)
        })
    }
    
    private func _purgeLines(upTo newSubdivision: GridLayer.Subdivision) {
        self._purgeLines(where: {
            $0._positionIndex.subdivision.rawValue < newSubdivision.rawValue
        })
    }
    
    private func _addLines(withOrientation orientation: LineLayer.Orientation, for positionIndexSet: _PositionIndexSet) {
        for positionIndex in positionIndexSet {
            let lineLayer: LineLayer = LineLayer()
            
            lineLayer._positionIndex = positionIndex
            lineLayer.orientation = orientation
            lineLayer.strokeColor = self._lineColor(for: lineLayer)
            lineLayer.lineWidth = self.gridLineWidth
            lineLayer.lineDashPattern = self.gridDashPattern as [NSNumber]
            lineLayer.length = self._length(for: lineLayer)
            
            self._lineLayers.append(lineLayer)
            self.addSublayer(lineLayer)
        }
    }
    
    private func _purgeLines(where predicate: ((LineLayer) -> Bool)) {
        let lineLayersToPurge: [LineLayer] = self._lineLayers.filter(predicate)
        for lineLayer in lineLayersToPurge {
            lineLayer.removeFromSuperlayer()
            self._lineLayers.remove_(lineLayer)
        }
    }
    
    private func _positionIndexSets(subdivs: [GridLayer.Subdivision], numOfRows: CGFloat, numOfColumns: CGFloat) -> _PositionIndexSets {
        if numOfRows == numOfColumns {
            let positionIndexSet: _PositionIndexSet = Set(self._positionIndices(
                subdivs: subdivs,
                from: 0,
                through: numOfRows
            ))
            return (positionIndexSet, positionIndexSet)
        }
        
        let moreRows: Bool = numOfRows > numOfColumns
        let smaller: CGFloat = moreRows ? numOfColumns : numOfRows
        let larger: CGFloat = moreRows ? numOfRows : numOfColumns
        
        var indicesForSmaller: [_PositionIndex] = []
        var indicesForLarger: [_PositionIndex] = []
        for subdivision in subdivs {
            indicesForSmaller += self._positionIndices(
                subdiv: subdivision,
                from: 0,
                through: smaller
            )
            
            indicesForLarger += indicesForSmaller
            indicesForLarger += self._positionIndices(
                subdiv: subdivision,
                from: smaller + subdivision.rawValue,
                through: larger
            )
        }
        
        let indexSetForSmaller: _PositionIndexSet = Set(indicesForSmaller)
        let indexSetForLarger: _PositionIndexSet = Set(indicesForLarger)
        return moreRows ? (indexSetForLarger, indexSetForSmaller) : (indexSetForSmaller, indexSetForLarger)
    }
    
    private func _positionIndices(subdivs: [GridLayer.Subdivision], from: CGFloat, through: CGFloat) -> [_PositionIndex] {
        var indices: [_PositionIndex] = []
        for subdivision in subdivs {
            indices += self._positionIndices(subdiv: subdivision, from: from, through: through)
        }
        return indices
    }
    
    private func _positionIndices(subdiv: GridLayer.Subdivision, from: CGFloat, through: CGFloat) -> [_PositionIndex] {
        return stride(
            from: from,
            through: through,
            by: subdiv.rawValue
        ).map({ _PositionIndex(value: $0, subdivision: subdiv) })
    }
    
    private func _lineColor(for line: LineLayer) -> CGColor {
        if line._positionIndex.subdivision == .none {
            return self.mainGridLineColor
        } else {
            return self.subGridLineColor
        }
    }
    
    private func _orthogonalOffset(for line: LineLayer) -> CGFloat {
        if line.orientation == .horizontal {
            return self._verticalOffset(forGridPosition: line._positionIndex.value)
        } else /*if line.orientation == .vertical*/ {
            return self._horizontalOffset(forGridPosition: line._positionIndex.value)
        }
    }
    
    private func _parallelInset(for line: LineLayer) -> CGFloat {
        if line.orientation == .horizontal {
            return (self._width() - self._lengthForRow(line)) / 2
        } else /*if line.orientation == .vertical*/ {
            return (self._height() - self._lengthForColumn(line)) / 2
        }
    }
    
    private func _length(for line: LineLayer) -> CGFloat {
        if line.orientation == .horizontal {
            return self._lengthForRow(line)
        } else /*if line.orientation == .vertical*/ {
            return self._lengthForColumn(line)
        }
    }
    
    private func _lengthForRow(_ row: LineLayer) -> CGFloat {
        // The layer is a row so its length is linear to the number of columns
        return (self._zeroedNumOfColumns + self._overlapFactor(for: row)) * self.columnWidth
    }
    
    private func _lengthForColumn(_ column: LineLayer) -> CGFloat {
        // The layer is a column so its length is linear to the number of rows
        return (self._zeroedNumOfRows + self._overlapFactor(for: column)) * self.rowHeight
    }
    
    private func _overlapFactor(for line: LineLayer) -> CGFloat {
        let subdivisionFactor: CGFloat = line._positionIndex.subdivision.rawValue
        return subdivisionFactor * self.gridLineOverlapFactor
    }
}


// MARK: Point <-> Location <-> SlotIndex Calculation
private extension GridLayer {
    func _point(for location: GridLayer.Location) -> CGPoint {
        return .zero
    }
    
    func _location(nearestTo point: CGPoint) -> GridLayer.Location {
        return (0, 0)
    }
    
    func _point(for slotIndex: UInt) -> CGPoint {
        return .zero
    }
    
    // Helpers
    func _horizontalOffset(forGridPosition gridPosition: CGFloat) -> CGFloat {
        return (self.gridInsetFactor + gridPosition) * self.columnWidth
    }
    
    func _verticalOffset(forGridPosition gridPosition: CGFloat) -> CGFloat {
        return (self.gridInsetFactor + gridPosition) * self.rowHeight
    }
}
