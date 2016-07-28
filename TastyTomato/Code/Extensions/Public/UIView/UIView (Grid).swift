//
//  UIView (Grid).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIView {
    public var sizeInGlobalGrid: SizeInGrid {
        get {
            return self._sizeInGlobalGrid
        }
        set(newSizeInGlobalGrid) {
            self._sizeInGlobalGrid = newSizeInGlobalGrid
        }
    }
}


// MARK: // Private
private extension UIView {
    private var _sizeInGlobalGrid: SizeInGrid {
        get {
            let unitSideLength: CGFloat = Grid.GlobalGrid.unitSideLength
            let width: CGFloat = self.width / unitSideLength
            let height: CGFloat = self.height / unitSideLength
            return CGSize(width: width, height: height)
        }
        set(newSizeInGlobalGrid) {
            let unitSideLength: CGFloat = Grid.GlobalGrid.unitSideLength
            let width: CGFloat = newSizeInGlobalGrid.width * unitSideLength
            let height: CGFloat = newSizeInGlobalGrid.height * unitSideLength
            self.size = CGSize(width: width, height: height)
        }
    }
}
