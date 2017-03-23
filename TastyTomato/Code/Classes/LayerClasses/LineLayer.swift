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
    public override init() {
        super.init()
    }
    
    // Private Variables
    fileprivate var __orientation: LineLayer.Orientation = .horizontal
}


// MARK: - // Private
// MARK: Computed Properties
private extension LineLayer {
    var _orientation: LineLayer.Orientation {
        get {
            return self.__orientation
        }
        set(newOrientation) {
            self.__orientation = newOrientation
            swap(&self.frame.size.width, &self.frame.size.height)
        }
    }
    
    var _parallelPosition: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return self.frame.origin.x
            case .vertical:
                return self.frame.origin.y
            }
        }
        set(newParallelPosition) {
            switch self.orientation {
            case .horizontal:
                self.frame.origin.x = newParallelPosition
            case .vertical:
                self.frame.origin.y = newParallelPosition
            }
        }
    }
    
    var _orthogonalPosition: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return self.frame.origin.y
            case .vertical:
                return self.frame.origin.x
            }
        }
        set(newOrthogonalPosition) {
            switch self.orientation {
            case .horizontal:
                self.frame.origin.y = newOrthogonalPosition
            case .vertical:
                self.frame.origin.x = newOrthogonalPosition
            }
        }
    }
    
    var _length: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return self.frame.width
            case .vertical:
                return self.frame.height
            }
        }
        set(newLength) {
            switch self.orientation {
            case .horizontal:
                self.frame.size.width = newLength
            case .vertical:
                self.frame.size.height = newLength
            }
        }
    }
    
    var _lineWidth: CGFloat {
        get {
            switch self.orientation {
            case .horizontal:
                return self.frame.height
            case .vertical:
                return self.frame.width
            }
        }
        set(newLineWidth) {
            switch self.orientation {
            case .horizontal:
                self.frame.size.height = newLineWidth
            case .vertical:
                self.frame.size.width = newLineWidth
            }
        }
    }
}
