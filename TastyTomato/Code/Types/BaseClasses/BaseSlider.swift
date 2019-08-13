//
//  BaseSlider.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 13.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BaseSlider: UISlider {
    // Required Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    // Common Init
    private func _init() {
        self.setColorAdjustment({ $0.tintColor = ColorScheme.lines.sliderTint })
    }
}
