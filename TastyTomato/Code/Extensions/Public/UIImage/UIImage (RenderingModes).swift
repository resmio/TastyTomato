//
//  UIImage (RenderingModes).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/28/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public extension UIImage {
    func inAutomaticMode() -> UIImage {
        return self._inAutomaticMode()
    }
    
    func asOriginal() -> UIImage {
        return self._asOriginal()
    }
    
    @objc func asTemplate() -> UIImage {
        return self._asTemplate()
    }
}


// MARK: // Private
private extension UIImage {
    func _inAutomaticMode() -> UIImage {
        return self.withRenderingMode(.automatic)
    }
    
    func _asOriginal() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
    func _asTemplate() -> UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
}
