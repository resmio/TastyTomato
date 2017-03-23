//
//  LineLayer.swift
//  TastyTomato
//
//  Created by Jan Nash on 11/24/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit
import ObjectiveC


// MARK: - // Public
// MARK: Interface
public extension LineLayer {
    // Enum Orientation
    public enum Orientation {
        case horizontal
        case vertical
    }
    
    // ReadWrite
    public var parallelPosition: CGFloat {
        get {
            return self._parallelPosition
        }
        set(newParallelPosition) {
            self._parallelPosition = newParallelPosition
        }
    }
    
    public var orthogonalPosition: CGFloat {
        get {
            return self._orthogonalPosition
        }
        set(newOrthogonalPosition) {
            self._orthogonalPosition = newOrthogonalPosition
        }
    }
    
    public var orientation: LineLayer.Orientation {
        get {
            return self._orientation
        }
        set(newOrientation) {
            self._orientation = newOrientation
        }
    }
    
    public var length: CGFloat {
        get {
            return self._length
        }
        set(newLength) {
            self._length = newLength
        }
    }
}


// MARK: Class Declaration
public class LineLayer: CAShapeLayer {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("LineLayer does not support NSCoding")
    }
    
    // Override Inits
    public override init() {
        super.init()
        self.lineWidth = 1
        self.strokeColor = UIColor.black.cgColor
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // Private Variables
    fileprivate var __orientation: LineLayer.Orientation = .horizontal
}


// MARK: Overrides
extension LineLayer {
    public override var lineWidth: CGFloat {
        get {
            return self._lineWidth
        }
        set(newLineWidth) {
            self._lineWidth = newLineWidth
        }
    }
}


// MARK: Unavailability Overrides
extension LineLayer {
    @available(*, unavailable)
    public override var frame: CGRect {
        get { fatalError() }
        set { fatalError() }
    }
    
    public override var backgroundColor: CGColor? {
        get { return nil }
        set { fatalError() }
    }
    
    @available(*, unavailable)
    public override var borderColor: CGColor? {
        get { return nil }
        set { fatalError() }
    }
    
    @available(*, unavailable)
    public override var fillColor: CGColor? {
        get { return nil }
        set { fatalError() }
    }
    
    @available(*, unavailable)
    public convenience init(frame: CGRect) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(size: CGSize) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(path p: UIBezierPath) { fatalError() }
    
    @available(*, unavailable)
    public convenience init(rect r: CGRect) { fatalError() }
}


// MARK: - // Private
// MARK: Computed Properties
private extension LineLayer {
    var _orientation: LineLayer.Orientation {
        get {
            return self.__orientation
        }
        set(newOrientation) {
            if newOrientation != self.__orientation {
                self.__orientation = newOrientation
                swap(&super.frame.size.width, &super.frame.size.height)
                self.path = self._createPath(
                    length: self.length,
                    orientation: newOrientation
                )
            }
        }
    }
    
    var _parallelPosition: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return super.frame.origin.x
            case .vertical:
                return super.frame.origin.y
            }
        }
        set(newParallelPosition) {
            switch self.orientation {
            case .horizontal:
                super.frame.origin.x = newParallelPosition
            case .vertical:
                super.frame.origin.y = newParallelPosition
            }
        }
    }
    
    var _orthogonalPosition: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return super.frame.origin.y
            case .vertical:
                return super.frame.origin.x
            }
        }
        set(newOrthogonalPosition) {
            switch self.orientation {
            case .horizontal:
                super.frame.origin.y = newOrthogonalPosition
            case .vertical:
                super.frame.origin.x = newOrthogonalPosition
            }
        }
    }
    
    var _length: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return super.frame.width
            case .vertical:
                return super.frame.height
            }
        }
        set(newLength) {
            let orientation: LineLayer.Orientation = self.orientation
            switch orientation {
            case .horizontal:
                super.frame.size.width = newLength
            case .vertical:
                super.frame.size.height = newLength
            }
            
            self.path = self._createPath(
                length: newLength,
                orientation: orientation
            )
        }
    }
    
    var _lineWidth: CGFloat {
        get {
            return super.lineWidth
        }
        set(newLineWidth) {
            switch self.orientation {
            case .horizontal:
                super.frame.size.height = newLineWidth
            case .vertical:
                super.frame.size.width = newLineWidth
            }
            super.lineWidth = newLineWidth
        }
    }
    
    // Private Helper
    private func _createPath(length: CGFloat, orientation: LineLayer.Orientation) -> CGPath? {
        guard length > 0 else {
            return nil
        }
        
        let path: CGMutablePath = CGMutablePath()
        switch orientation {
        case .horizontal:
            path.addLines(between: [.zero, CGPoint(x: length, y: 0)])
        case .vertical:
            path.addLines(between: [.zero, CGPoint(x: 0, y: length)])
        }
        
        return path
    }
}
