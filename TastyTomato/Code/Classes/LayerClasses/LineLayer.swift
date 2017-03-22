//
//  LineLayer.swift
//  TastyTomato
//
//  Created by Jan Nash on 11/24/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
public extension LineLayer {
    public enum Orientation: Int {
        case horizontal
        case vertical
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
    fileprivate var __orientation: LineLayer.Orientation = .horizontal
}


// MARK: Overrides
public extension LineLayer {
    public override var frame: CGRect {
        get {
            return self._frame
        }
        set(newFrame) {
            self._frame = newFrame
        }
    }
}


// MARK: // Private
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


// MARK: Override Implementations
private extension LineLayer {
    var _frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            // Fixing the lineWidth
            var fixedFrame: CGRect = newFrame
            switch self.orientation {
            case .horizontal:
                fixedFrame.size.height = self.lineWidth
            case .vertical:
                fixedFrame.size.width = self.lineWidth
            }
            super.frame = fixedFrame
        }
    }
}
