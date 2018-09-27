//
//  UIViewController (Embedding).swift
//  TastyTomato
//
//  Created by Jan Nash on 9/5/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIViewController {
    @objc public func embed(_ viewController: UIViewController, into view: UIView? = nil) {
        self._embed(
            viewController,
            into: view,
            in: nil
        )
    }
    
    public func embed(_ viewController: UIViewController, into view: UIView? = nil, in frame: CGRect) {
        self._embed(
            viewController,
            into: view,
            in: frame
        )
    }
}


// MARK: // Private
private extension UIViewController {
    func _embed(_ viewController: UIViewController, into view: UIView?, in frame: CGRect?) {
        let containerView: UIView = view ?? self.view
        let containerFrame: CGRect = frame ?? containerView.bounds
        let vcView: UIView = viewController.view
        
        self.addChild(viewController)
        vcView.frame = containerFrame
        containerView.addSubview(vcView)
        viewController.didMove(toParent: self)
    }
}
