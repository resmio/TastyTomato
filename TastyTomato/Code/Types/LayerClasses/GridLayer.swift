//
//  GridLayer.swift
//  TastyTomato
//
//  Created by Jan Nash on 3/27/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import Foundation
import SignificantSpices


// MARK: // Public
// MARK: Interface
public extension GridLayer {
    // MARK: Location
    typealias Location = (row: CGFloat, column: CGFloat)
    
    enum Subdivision: CGFloat {
        case none = 1.0
        case half = 0.5
        case quarter = 0.25
        case eighth = 0.125
        
        // This list MUST be sorted by descending rawValue
        // If it isn't, bad things will happen in the code below!
        fileprivate static let _divisions: [GridLayer.Subdivision] = [.none, .half, .quarter, .eighth]
    }
    
    // ReadWrite
    var numOfRows: UInt {
        get { return self._numOfRows }
        set { self._numOfRows = newValue }
    }
    
    var numOfColumns: UInt {
        get { return self._numOfColumns }
        set { self._numOfColumns = newValue }
    }

    var subdivision: GridLayer.Subdivision {
        get { return self._subdivision }
        set { self._subdivision = newValue }
    }
    
    var gridIsShown: Bool {
        get { return self._gridIsShown }
        set { self._gridIsShown = newValue }
    }
    
    var borderIsShown: Bool {
        get { return self._borderIsShown }
        set { self._borderIsShown = newValue }
    }
    
    var rowHeight: CGFloat {
        get { return self._rowHeight }
        set { self._rowHeight = newValue }
    }
    
    var columnWidth: CGFloat {
        get { return self._columnWidth }
        set { self._columnWidth = newValue }
    }
    
    var borderLineColor: CGColor {
        get { return self._borderLineColor }
        set { self._borderLineColor = newValue }
    }
    
    var mainGridLineColor: CGColor {
        get { return self._mainGridLineColor }
        set { self._mainGridLineColor = newValue }
    }
    
    var subGridLineColor: CGColor {
        get { return self._subGridLineColor }
        set { self._subGridLineColor = newValue }
    }
    
    var borderLineWidth: CGFloat {
        get { return self._borderLineWidth }
        set { self._borderLineWidth = newValue }
    }
    
    var gridLineWidth: CGFloat {
        get { return self._gridLineWidth }
        set { self._gridLineWidth = newValue }
    }
    
    var borderDashPattern: [CGFloat] {
        get { return self._borderDashPattern as! [CGFloat] }
        set { self._borderDashPattern = newValue as [NSNumber] }
    }
    
    var gridDashPattern: [CGFloat] {
        get { return self._gridDashPattern as! [CGFloat] }
        set { self._gridDashPattern = newValue as [NSNumber] }
    }
    
    var borderEdgeInsets: UIEdgeInsets {
        get { return self._borderEdgeInsets }
        set { self._borderEdgeInsets = newValue }
    }
    
    var gridInsetFactor: CGFloat {
        get { return self._gridInsetFactor }
        set { self._gridInsetFactor = newValue }
    }
    
    var gridLineOverlapFactor: CGFloat {
        get { return self._gridLineOverlapFactor }
        set { self._gridLineOverlapFactor = newValue }
    }

    // Functions
    func point(for location: GridLayer.Location) -> CGPoint {
        return self._point(for: location)
    }

    func location(for point: CGPoint, snapToGrid: Bool) -> GridLayer.Location {
        return self._location(for: point, snapToGrid: snapToGrid)
    }
}


// MARK: Class Declaration
public class GridLayer: CALayer {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Inits
    public override init() {
        super.init()
        self._init()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // Common Init
    private func _init() {
        self._addOrRemoveBorderLayer()
        self._addOrRemoveLineLayers()
        self._sizeFrame()
    }
    
    // Private Lazy Variables
    // ALOs
    private lazy var _borderLayer: ALO<BorderLayer> = ALO({ [unowned self] in self._createBorderLayer() })
    
    // Private Variables
    private var _lineLayers: [LineLayer] = []
    
    private var __subdivision: GridLayer.Subdivision = .none
    private var __gridIsShown: Bool = false
    private var __borderIsShown: Bool = true
    private var __rowHeight: CGFloat = 150
    private var __columnWidth: CGFloat = 150
    private var __borderLineColor: CGColor = UIColor.gray999999.withAlpha(0.8).cgColor
    private var __mainGridLineColor: CGColor = UIColor.gray999999.withAlpha(0.8).cgColor
    private var __subGridLineColor: CGColor = UIColor.gray999999.withAlpha(0.4).cgColor
    private var __borderLineWidth: CGFloat = 1
    private var __gridLineWidth: CGFloat = 1
    private var __borderDashPattern: [NSNumber] = []
    private var __gridDashPattern: [NSNumber] = []
    private var __borderEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private var __gridInsetFactor: CGFloat = 0.6
    private var __gridLineOverlapFactor: CGFloat = 0.4
    
    private var __numOfRows: UInt = 8
    private var __numOfColumns: UInt = 8
    
    
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
// MARK: Lazy Variable Creation
private extension GridLayer {
    func _createBorderLayer() -> BorderLayer {
        let borderLayer: BorderLayer = BorderLayer()
        borderLayer.lineWidth = self.borderLineWidth
        borderLayer.lineDashPattern = self.borderDashPattern as [NSNumber]
        borderLayer.borderEdgeInsets = self.borderEdgeInsets
        return borderLayer
    }
}


// MARK: Computed Properties
private extension GridLayer {
    var _numOfRows: UInt {
        get { return self.__numOfRows }
        set(newNumOfRows) {
            guard newNumOfRows != self.__numOfRows else { return }
            if self.gridIsShown {
                self._addOrRemoveRowLineLayers(
                    oldNumOfRows: self.__numOfRows,
                    newNumOfRows: newNumOfRows
                )
                self._forEachLine(
                    where: { $0.orientation == .vertical },
                    execute: { $0.length = self._lengthFor(column: $0) }
                )
            }
            self.__numOfRows = newNumOfRows
            self._sizeFrame()
        }
    }
    
    var _numOfColumns: UInt {
        get { return self.__numOfColumns }
        set(newNumOfColumns) {
            guard newNumOfColumns != self.__numOfColumns else { return }
            if self.gridIsShown {
                self._addOrRemoveColumnLineLayers(
                    oldNumOfColumns: self.__numOfColumns,
                    newNumOfColumns: newNumOfColumns
                )
                self._forEachLine(
                    where: { $0.orientation == .horizontal },
                    execute: { $0.length = self._lengthFor(row: $0) }
                )
            }
            self.__numOfColumns = newNumOfColumns
            self._sizeFrame()
        }
    }
    
    var _subdivision: GridLayer.Subdivision {
        get { return self.__subdivision }
        set(newSubdivision) {
            guard newSubdivision != self.__subdivision else { return }
            if self.gridIsShown {
                self._addOrRemoveLineLayers(
                    oldSubdivision: self.__subdivision,
                    newSubdivision: newSubdivision
                )
            }
            self.__subdivision = newSubdivision
        }
    }
    
    var _gridIsShown: Bool {
        get { return self.__gridIsShown }
        set(newGridIsShown) {
            guard newGridIsShown != self.__gridIsShown else { return }
            self.__gridIsShown = newGridIsShown
            self._addOrRemoveLineLayers()
        }
    }
    
    var _borderIsShown: Bool {
        get { return self.__borderIsShown }
        set(newBorderIsShown) {
            guard newBorderIsShown != self.__borderIsShown else { return }
            self.__borderIsShown = newBorderIsShown
            self._addOrRemoveBorderLayer()
        }
    }
    
    var _rowHeight: CGFloat {
        get { return self.__rowHeight }
        set(newRowHeight) {
            guard newRowHeight != self.__rowHeight else { return }
            self.__rowHeight = newRowHeight
            self._sizeFrameAndSetNeedsLayout()
        }
    }
    
    var _columnWidth: CGFloat {
        get { return self.__columnWidth }
        set(newColumnWidth) {
            guard newColumnWidth != self.__columnWidth else { return }
            self.__columnWidth = newColumnWidth
            self._sizeFrameAndSetNeedsLayout()
        }
    }
    
    var _borderLineColor: CGColor {
        get { return self.__borderLineColor }
        set(newBorderLineColor) {
            guard newBorderLineColor != self.__borderLineColor else { return }
            self.__borderLineColor = newBorderLineColor
            (self._borderLayer¿)?.strokeColor = newBorderLineColor
        }
    }
    
    var _mainGridLineColor: CGColor {
        get { return self.__mainGridLineColor }
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
        get { return self.__subGridLineColor }
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
        get { return self.__borderLineWidth }
        set(newBorderLineWidth) {
            guard newBorderLineWidth != self.__borderLineWidth else { return }
            self.__borderLineWidth = newBorderLineWidth
            (self._borderLayer¿)?.lineWidth = newBorderLineWidth
        }
    }
    
    var _gridLineWidth: CGFloat {
        get { return self.__gridLineWidth }
        set(newGridLineWidth) {
            guard newGridLineWidth != self.__gridLineWidth else { return }
            self.__gridLineWidth = newGridLineWidth
            self._lineLayers.forEach({ $0.lineWidth = newGridLineWidth })
        }
    }
    
    var _borderDashPattern: [NSNumber] {
        get { return self.__borderDashPattern }
        set(newBorderDashPattern) {
            guard newBorderDashPattern != self.__borderDashPattern else { return }
            self.__borderDashPattern = newBorderDashPattern
            (self._borderLayer¿)?.lineDashPattern = newBorderDashPattern
        }
    }
    
    var _gridDashPattern: [NSNumber] {
        get { return self.__gridDashPattern }
        set(newGridDashPattern) {
            guard newGridDashPattern != self.__gridDashPattern else { return }
            self.__gridDashPattern = newGridDashPattern
            self._lineLayers.forEach({ $0.lineDashPattern = newGridDashPattern })
        }
    }
    
    var _borderEdgeInsets: UIEdgeInsets {
        get { return self.__borderEdgeInsets }
        set(newBorderEdgeInsets) {
            guard newBorderEdgeInsets != self.__borderEdgeInsets else { return }
            self.__borderEdgeInsets = newBorderEdgeInsets
            (self._borderLayer¿)?.borderEdgeInsets = newBorderEdgeInsets
        }
    }
    
    var _gridInsetFactor: CGFloat {
        get { return self.__gridInsetFactor }
        set(newGridInsetFactor) {
            guard newGridInsetFactor != self.__gridInsetFactor else { return }
            self.__gridInsetFactor = newGridInsetFactor
            self._sizeFrameAndSetNeedsLayout()
        }
    }
    
    var _gridLineOverlapFactor: CGFloat {
        get { return self.__gridLineOverlapFactor }
        set(newGridLineOverlapFactor) {
            guard newGridLineOverlapFactor != self.__gridLineOverlapFactor else { return }
            self.__gridLineOverlapFactor = newGridLineOverlapFactor
            self._sizeFrameAndSetNeedsLayout()
        }
    }
    
    // Helpers
    var _zeroedNumOfColumns: Int {
        return Int(self.numOfColumns - 1)
    }
    
    var _zeroedNumOfRows: Int {
        return Int(self.numOfRows - 1)
    }
}


// MARK: Override Implementations
private extension GridLayer {
    func _preferredFrameSize() -> CGSize {
        return CGSize(width: self._width(), height: self._height())
    }
    
    func _layoutSublayers() {
        self._lineLayers.forEach({ line in
            switch line.orientation {
            case .horizontal:
                line.length = self._lengthFor(row: line)
                line.parallelPosition = self._parallelPositionFor(row: line)
                line.orthogonalPosition = self._orthogonalPositionFor(row: line)
            case .vertical:
                line.length = self._lengthFor(column: line)
                line.parallelPosition = self._parallelPositionFor(column: line)
                line.orthogonalPosition = self._orthogonalPositionFor(column: line)
            }
        })
    }
    
    // Helpers
    func _sizeFrame() {
        let frameSize: CGSize = self.preferredFrameSize()
        self.frame.size = frameSize
        (self._borderLayer¿)?.frame.size = frameSize
    }
    
    func _sizeFrameAndSetNeedsLayout() {
        self._sizeFrame()
        self.setNeedsLayout()
    }
    
    func _width() -> CGFloat {
        return ((2 * self.gridInsetFactor) + CGFloat(self._zeroedNumOfColumns)) * self.columnWidth
    }
    
    func _height() -> CGFloat {
        return ((2 * self.gridInsetFactor) + CGFloat(self._zeroedNumOfRows)) * self.rowHeight
    }
}


// MARK: - LineLayer
// MARK: AssociationKeys
private extension ValueAssociationKey {
    static var _positionIndex: ValueAssociationKey = ValueAssociationKey()
}


// MARK: Virtual Property
extension LineLayer: AssociationOwner {}
private extension LineLayer {
    var _positionIndex: _PositionIndex {
        get { return self.associatedValue(for: &._positionIndex)! }
        set { self.associate(newValue, by: &._positionIndex) }
    }
}


// MARK: - _PositionIndex
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
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
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
// MARK: Position And Length Calculation For LineLayers
private extension GridLayer {
    func _lengthFor(row: LineLayer) -> CGFloat {
        return (CGFloat(self._zeroedNumOfColumns) + self._overlapFactor(for: row)) * self.columnWidth
    }
    
    func _lengthFor(column: LineLayer) -> CGFloat {
        return (CGFloat(self._zeroedNumOfRows) + self._overlapFactor(for: column)) * self.rowHeight
    }
    
    func _parallelPositionFor(row: LineLayer) -> CGFloat {
        return (self._width() - self._lengthFor(row: row)) / 2
    }
    
    func _parallelPositionFor(column: LineLayer) -> CGFloat {
        return (self._height() - self._lengthFor(column: column)) / 2
    }
    
    func _orthogonalPositionFor(row: LineLayer) -> CGFloat {
        return self._verticalAbsOffset(forGridPosition: row._positionIndex.value)
    }
    
    func _orthogonalPositionFor(column: LineLayer) -> CGFloat {
        return self._horizontalAbsOffset(forGridPosition: column._positionIndex.value)
    }
    
    func _overlapFactor(for line: LineLayer) -> CGFloat {
        return line._positionIndex.subdivision.rawValue * self.gridLineOverlapFactor
    }
}


// MARK: Color Calculation for LineLayer
private extension GridLayer {
    func _lineColor(for line: LineLayer) -> CGColor {
        switch line._positionIndex.subdivision {
        case .none: return self.mainGridLineColor
        default:    return self.subGridLineColor
        }
    }
}


// MARK: Update LineLayers
private extension GridLayer {
    func _forEachLine(where condition: ((LineLayer) -> Bool), execute: (LineLayer) -> Void) {
        self._lineLayers.forEach({
            if condition($0) {
                execute($0)
            }
        })
    }
}


// MARK: Add Or Remove BorderLayer
private extension GridLayer {
    func _addOrRemoveBorderLayer() {
        if self.borderIsShown && self.gridInsetFactor != 0 {
            self.addSublayer(self._borderLayer¡)
        } else {
            (self._borderLayer¿)?.removeFromSuperlayer()
            self._borderLayer.clear()
        }
    }
}


// MARK: Add Or Remove LineLayers
private extension GridLayer {
    func _addOrRemoveLineLayers() {
        self.gridIsShown ? self._addLineLayers() : self._removeLineLayers()
    }
    
    func _addOrRemoveRowLineLayers(oldNumOfRows: UInt, newNumOfRows: UInt) {
        if newNumOfRows > oldNumOfRows {
            self._addLines(withOrientation: .horizontal, after: oldNumOfRows, through: newNumOfRows)
        } else if newNumOfRows < oldNumOfRows {
            self._purgeRows(downTo: newNumOfRows)
        }
    }
    
    func _addOrRemoveColumnLineLayers(oldNumOfColumns: UInt, newNumOfColumns: UInt) {
        if newNumOfColumns > oldNumOfColumns {
            self._addLines(withOrientation: .vertical, after: oldNumOfColumns, through: newNumOfColumns)
        } else if newNumOfColumns < oldNumOfColumns {
            self._purgeColumns(downTo: newNumOfColumns)
        }
    }
    
    func _addOrRemoveLineLayers(oldSubdivision: GridLayer.Subdivision, newSubdivision: GridLayer.Subdivision) {
        if newSubdivision.rawValue < oldSubdivision.rawValue {
            self._addLines(after: oldSubdivision, through: newSubdivision)
        } else if newSubdivision.rawValue > oldSubdivision.rawValue {
            self._purgeLines(upTo: newSubdivision)
        }
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
            switch line.orientation {
            case .horizontal:   rowIndices.append(line._positionIndex)
            case .vertical:     columnIndices.append(line._positionIndex)
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
            $0._positionIndex.value > (CGFloat(numOfRows) - 1)
        })
    }
    
    private func _purgeColumns(downTo numOfRows: UInt) {
        self._purgeLines(where: {
            $0.orientation == .vertical &&
            $0._positionIndex.value > (CGFloat(numOfRows) - 1)
        })
    }
    
    private func _purgeLines(upTo newSubdivision: GridLayer.Subdivision) {
        self._purgeLines(where: {
            $0._positionIndex.subdivision.rawValue < newSubdivision.rawValue
        })
    }
    
    private func _addLines(withOrientation orientation: LineLayer.Orientation, for positionIndexSet: _PositionIndexSet) {
        let __lengthOf: (LineLayer) -> CGFloat = {
            switch orientation {
            case .horizontal:   return self._lengthFor(row:)
            case .vertical:     return self._lengthFor(column:)
            }
        }()
        
        for positionIndex in positionIndexSet {
            let lineLayer: LineLayer = LineLayer()
            
            lineLayer._positionIndex = positionIndex
            lineLayer.orientation = orientation
            lineLayer.strokeColor = self._lineColor(for: lineLayer)
            lineLayer.lineWidth = self.gridLineWidth
            lineLayer.lineDashPattern = self.gridDashPattern as [NSNumber]
            lineLayer.length = __lengthOf(lineLayer)
            
            self._lineLayers.append(lineLayer)
            self.addSublayer(lineLayer)
        }
    }
    
    private func _purgeLines(where predicate: ((LineLayer) -> Bool)) {
        let lineLayersToPurge: [LineLayer] = self._lineLayers.filter(predicate)
        for lineLayer in lineLayersToPurge {
            lineLayer.removeFromSuperlayer()
            self._lineLayers.remove(lineLayer)
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
}


// MARK: Point <-> Location <-> SlotIndex Calculation
private extension GridLayer {
    func _point(for location: GridLayer.Location) -> CGPoint {
        return CGPoint(
            x: self._horizontalAbsOffset(forGridPosition: location.column),
            y: self._verticalAbsOffset(forGridPosition: location.row)
        )
    }
    
    func _location(for point: CGPoint, snapToGrid: Bool) -> GridLayer.Location {
        let minTotalX: CGFloat = self._horizontalAbsOffset(forGridPosition: 0)
        let maxTotalX: CGFloat = self._horizontalAbsOffset(forGridPosition: CGFloat(self._zeroedNumOfColumns))
        let minTotalY: CGFloat = self._verticalAbsOffset(forGridPosition: 0)
        let maxTotalY: CGFloat = self._verticalAbsOffset(forGridPosition: CGFloat(self._zeroedNumOfRows))
        
        let clampedTotalX: CGFloat = max(minTotalX, min(maxTotalX, point.x))
        let clampedTotalY: CGFloat = max(minTotalY, min(maxTotalY, point.y))
        
        let insetFactor: CGFloat = self.gridInsetFactor
        
        let exactRowValue: CGFloat = (clampedTotalY / self.rowHeight) - insetFactor
        let exactColumnValue: CGFloat = (clampedTotalX / self.columnWidth) - insetFactor
        
        guard snapToGrid else {
            return (exactRowValue, exactColumnValue)
        }
        
        return (
            self._roundToSubdivision(exactRowValue),
            self._roundToSubdivision(exactColumnValue)
        )
    }
    
    // Helpers
    func _horizontalAbsOffset(forGridPosition gridPosition: CGFloat) -> CGFloat {
        return (self.gridInsetFactor + gridPosition) * self.columnWidth
    }
    
    func _verticalAbsOffset(forGridPosition gridPosition: CGFloat) -> CGFloat {
        return (self.gridInsetFactor + gridPosition) * self.rowHeight
    }
    
    func _roundToSubdivision(_ position: CGFloat) -> CGFloat {
        let invertedSubdivision: CGFloat = 1 / self.subdivision.rawValue
        return round(position * invertedSubdivision) / invertedSubdivision
    }
}
