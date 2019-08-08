//
//  ColorAdjuster.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 08.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Interface
public extension ColorAdjuster {
    func adjust() {
        self._closure(self._view)
    }
}


// MARK: Class Declaration
public class ColorAdjuster<T: UIView>: NSObject {
    // Init
    public init(_ view: T, _ closure: @escaping (T?) -> Void) {
        self._view = view
        self._closure = closure
    }
    
    // Private Constants
    private let _closure: (T?) -> Void
    
    // Private Weak Variables
    private weak var _view: T?
}
