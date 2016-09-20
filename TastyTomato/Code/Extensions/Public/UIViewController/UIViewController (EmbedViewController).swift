//
//  UIViewController (EmbedViewController).swift
//  TastyTomato
//
//  Created by Jan Nash on 9/5/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIViewController {
    public func embedViewController(_ viewController: UIViewController, inView view: UIView? = nil) {
        self._embedViewController(
            viewController,
            inView: view,
            inFrame: nil
        )
    }
    
    public func embedViewController(_ viewController: UIViewController, inView view: UIView? = nil, inFrame frame: CGRect) {
        self._embedViewController(
            viewController,
            inView: view,
            inFrame: frame
        )
    }
}


// MARK: // Private
private extension UIViewController {
    func _embedViewController(_ viewController: UIViewController, inView view: UIView?, inFrame frame: CGRect?) {
        let containerView: UIView = view ?? self.view
        let containerFrame: CGRect = frame ?? containerView.bounds
        let vcView: UIView = viewController.view
        vcView.frame = containerFrame
        
        viewController.willMove(toParentViewController: self)
        self.addChildViewController(viewController)
        containerView.addSubview(vcView)
        viewController.didMove(toParentViewController: self)
    }
}
