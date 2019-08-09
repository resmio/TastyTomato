//
//  BaseSwitch.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 09.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Class Declaration
public class BaseSwitch: UISwitch {
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
        self.layer.cornerRadius = self.height / 2
        self.setColorAdjustment({
            let swtch: BaseSwitch? = $0 as? BaseSwitch
            swtch?.tintColor = ColorScheme.lines.switchBorder
            swtch?.onTintColor = ColorScheme.background.switchOn
            swtch?.backgroundColor = ColorScheme.background.switchOff
        })
    }
}
