//
//  UIBarButtonItem (Factories).swift
//  TastyTomato
//
//  Created by Jan Nash on 4/25/17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Factories
public extension UIBarButtonItem {
    public typealias TargetAction = (target: AnyObject, action: Selector)
    
    public static func makeCancelItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeCancelItem(targetAction: targetAction)
    }
    
    public static func makeDeleteItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeDeleteItem(targetAction: targetAction)
    }
    
    public static func makeOfflineItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeOfflineItem(targetAction: targetAction)
    }
    
    public static func makeEditItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeEditItem(targetAction: targetAction)
    }
    
    public static func makeNewItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeNewItem(targetAction: targetAction)
    }
    
    public static func makeSaveItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeSaveItem(targetAction: targetAction)
    }
}


// MARK: // Private
private extension UIBarButtonItem {
    static func _makeCancelItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getButton(targetAction)
        button.setTitle(NSL_("Cancel"))
        button.sizeToFit()
        button.tintColor = .redE62C4F
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeDeleteItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getButton(targetAction)
        button.setTitle(NSL_("Delete"))
        button.sizeToFit()
        button.tintColor = .redE62C4F
        button.setTitleColor(.gray999999, for: .disabled)
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeOfflineItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let offlineImage: UIImage = MiscIcon.Offline.asTemplate()
        let button: UIButton = self._getButton(targetAction)
        button.setBackgroundImage(offlineImage, for: .normal)
        button.sizeToFit()
        button.tintColor = .redE62C4F
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeEditItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getButton(targetAction)
        button.setTitle(NSL_("Edit"))
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        button.setTitleColor(.gray999999, for: .disabled)
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeNewItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getButton(targetAction)
        button.setTitle(NSL_("New"))
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        button.setTitleColor(.gray999999, for: .disabled)
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeSaveItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getButton(targetAction)
        button.setTitle(NSL_("Save"))
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        button.setTitleColor(.gray999999, for: .disabled)
        return UIBarButtonItem(customView: button)
    }
    
    // Helpers
    private static func _getButton(_ targetAction: TargetAction?) -> UIButton {
        let button: UIButton = UIButton(type: .system)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.isExclusiveTouch = true
        
        if let (target, action) = targetAction {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        
        return button
    }
}
