//
//  LineLayer.swift
//  TastyTomato
//
//  Created by Jan Nash on 11/24/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: - // Public
// MARK: - LineLayerConfiguration
// MARK: Struct Declaration
public struct LineLayerConfiguration {
    let parallelPosition: CGFloat = 0
    let orthogonalPosition: CGFloat = 0
    let orientation: LineLayer.Orientation = .horizontal
    let lineWidth: CGFloat = 1
    let length: CGFloat = 0
}


// MARK: - LineLayer
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
    
    public var lineWidth: CGFloat {
        get {
            return self._lineWidth
        }
        set(newLineWidth) {
            self._lineWidth = newLineWidth
        }
    }
}


// MARK: Class Declaration
public class LineLayer: CALayer {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("LineLayer does not support NSCoding")
    }
    
    // Init
    public init(configuration: LineLayerConfiguration = LineLayerConfiguration()) {
        self.__orientation = configuration.orientation
        super.init()
        self.length = configuration.length
        self.lineWidth = configuration.lineWidth
        self.parallelPosition = configuration.parallelPosition
        self.orthogonalPosition = configuration.orthogonalPosition
    }
    
    // Private Variables
    fileprivate var __orientation: LineLayer.Orientation
}


// MARK: Unavailability Overrides
public extension LineLayer {
    @available(*, unavailable)
    public final override var frame: CGRect {
        get { return .null }
        set {}
    }
    
    @available(*, unavailable)
    public final override var bounds: CGRect {
        get { return .null }
        set {}
    }
    
    @available(*, unavailable)
    public convenience init(frame: CGRect) {
        fatalError()
    }
    
    @available(*, unavailable)
    public convenience init(size: CGSize) {
        fatalError()
    }
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
                // Order is important here
                swap(&self.length, &self.lineWidth)
                self.__orientation = newOrientation
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
                return super.frame.origin.x = newParallelPosition
            case .vertical:
                return super.frame.origin.y = newParallelPosition
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
                return super.frame.origin.y = newOrthogonalPosition
            case .vertical:
                return super.frame.origin.x = newOrthogonalPosition
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
            switch self.orientation {
            case .horizontal:
                super.frame.size.width = newLength
            case .vertical:
                super.frame.size.height = newLength
            }
        }
    }
    
    var _lineWidth: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return super.frame.height
            case .vertical:
                return super.frame.width
            }
        }
        set(newLineWidth) {
            switch self.orientation {
            case .horizontal:
                super.frame.size.height = newLineWidth
            case .vertical:
                super.frame.size.width = newLineWidth
            }
        }
    }
}
