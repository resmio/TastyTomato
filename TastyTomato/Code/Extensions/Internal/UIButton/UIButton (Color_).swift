//
//  UIButton (Color_).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
extension UIButton {
    func setColor_(_ color: UIColor, for state: UIControlState) {
        self._setColor(color, for: state)
    }
}


// MARK: // Private
private extension UIButton {
    func _setColor(_ color: UIColor, for state: UIControlState) {
        let image: UIImage? = UIImage.coloredRect(size: self.size, color: color)
        self.setBackgroundImage(image, for: state)
    }
}
