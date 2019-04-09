//
//  UITableView (reloadSoftly).swift
//  TastyTomato
//
//  Created by Jan Nash on 7/11/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UITableView {
    func reloadSoftly(animated: Bool = true, duration: TimeInterval = 0.4, additionalAnimations: (() -> Void)? = nil) {
        self._reloadSoftly(animated: animated, duration: duration, additionalAnimations: additionalAnimations)
    }
}


// MARK: // Private
private extension UITableView {
    func _reloadSoftly(animated: Bool, duration: TimeInterval, additionalAnimations: (() -> Void)?) {
        let reload: (() -> Void) = {
            self.beginUpdates()
            additionalAnimations?()
            self.endUpdates()
        }
        
        if animated {
            UIView.animate(withDuration: duration, animations: reload)
        } else {
            UIView.performWithoutAnimation(reload)
        }
    }
}
