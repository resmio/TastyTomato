//
//  BaseStepper.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 13.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BaseStepper: UIStepper {
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
        self.setColorAdjustment({
            guard let stepper: UIStepper = $0 as? UIStepper else { return }
            // This seems to be necessary due to a bug in iOS 13
            // See https://forums.developer.apple.com/thread/121495
            let state: UIControl.State = .normal
            stepper.setDecrementImage(nil, for: state)
            stepper.setIncrementImage(nil, for: state)
            stepper.tintColor = ColorScheme.lines.stepperTint
        })
    }
}
