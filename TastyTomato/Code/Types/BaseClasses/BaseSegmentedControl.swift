//
//  BaseSegmentedControl.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 12.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BaseSegmentedControl: UISegmentedControl {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Inits
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    public override init(items: [Any]?) {
        super.init(items: items)
        self._init()
    }
    
    // Common Init
    private func _init() {
        self.setColorAdjustment({
            $0.backgroundColor = .clear
            $0.tintColor = ColorScheme.lines.segmentedControl
        })
    }
}
