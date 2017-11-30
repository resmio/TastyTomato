//
//  RootViewController.swift
//  TastyTomato
//
//  Created by Jan Nash on 5/19/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Interface
extension RootViewController {
    var child: UIViewController? {
        get {
            return self._child
        }
        set(newChild) {
            self._child = newChild
        }
    }
}


// MARK: Class Declaration
class RootViewController: UIViewController {
    // Private Variables
    fileprivate var __child: UIViewController?
}


// MARK: // Private
// MARK: Computed Variables
private extension RootViewController {
    var _child: UIViewController? {
        get {
            return self.__child
        }
        set(newChild) {
            guard newChild != self.__child else { return }
            if let oldChild: UIViewController = self.__child {
                oldChild.willMove(toParentViewController: nil)
                oldChild.view.removeFromSuperview()
                oldChild.removeFromParentViewController()
            }
            
            if let newChild: UIViewController = newChild {
                self.embed(newChild)
            }
            
            self.__child = newChild
        }
    }
}
