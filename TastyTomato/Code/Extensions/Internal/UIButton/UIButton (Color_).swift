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
    func setColor_(color: UIColor, forState state: UIControlState) {
        self._setColor(color, forState: state)
    }
}


// MARK: // Private
private extension UIButton {
    private func _setColor(color: UIColor, forState state: UIControlState) {
        let image: UIImage? = UIImage.coloredRect(size: self.size, color: color)
        self.setBackgroundImage(image, forState: state)
    }
}
