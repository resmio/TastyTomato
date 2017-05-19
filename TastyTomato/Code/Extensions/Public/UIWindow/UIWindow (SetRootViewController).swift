//
//  UIWindow (SetRootViewController).swift
//  TastyTomato
//
//  Created by Jan Nash on 5/19/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public extension UIWindow {
    public func setRootVC(_ newRootVC: UIViewController, transition: UIViewAnimationTransition = .none, completion: (() -> Void)? = nil) {
        self._setRootVC(newRootVC, transition: transition, completion: completion)
    }
}


// MARK: // Private
private extension UIWindow {
    func _setRootVC(_ newRootVC: UIViewController, transition: UIViewAnimationTransition, completion: (() -> Void)?) {
        let setNewChildAndCallCompletion: ((RootViewController) -> Void) = {
            $0.child = newRootVC
            completion?()
        }
        
        guard let realRootVC: RootViewController = self.rootViewController as? RootViewController else {
            let realRootVC: RootViewController = RootViewController()
            self.rootViewController = realRootVC
            setNewChildAndCallCompletion(realRootVC)
            return
        }
        
        guard let oldRootVC: UIViewController = realRootVC.child else {
            setNewChildAndCallCompletion(realRootVC)
            return
        }
        
        guard let transitionOptions: UIViewAnimationOptions = self._getAnimationOptions(for: transition) else {
            setNewChildAndCallCompletion(realRootVC)
            return
        }
        
        UIView.transition(
            from: oldRootVC.view,
            to: newRootVC.view,
            duration: 0.3,
            options: transitionOptions,
            completion: { _ in setNewChildAndCallCompletion(realRootVC) }
        )
    }
    
    // Private Helper
    private func _getAnimationOptions(for transition: UIViewAnimationTransition) -> UIViewAnimationOptions? {
        let defaultOptions: UIViewAnimationOptions = [.allowAnimatedContent, .curveEaseInOut]
        var additionalOptions: UIViewAnimationOptions
        
        switch transition {
        case .curlUp:
            additionalOptions = .transitionCurlUp
        case .curlDown:
            additionalOptions = .transitionCurlDown
        case .flipFromLeft:
            additionalOptions = .transitionFlipFromLeft
        case .flipFromRight:
            additionalOptions = .transitionFlipFromRight
        case .none:
            return nil
        }
        
        return [defaultOptions, additionalOptions]
    }
}
