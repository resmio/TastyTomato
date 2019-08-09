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
    func adjust(_ view: UIView) {
        self._closure(view)
    }
}


// MARK: Class Declaration
public class ColorAdjuster: NSObject {
    // Init
    public init(_ closure: @escaping (UIView) -> Void) {
        self._closure = closure
    }
    
    // Private Constants
    private let _closure: (UIView) -> Void
}
