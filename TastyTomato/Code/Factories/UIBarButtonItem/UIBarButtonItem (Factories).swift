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
// MARK: Buttons
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
    
    public static func makeBackItem(targetAction: TargetAction?) -> UIBarButtonItem {
        return ._makeBackItem(targetAction: targetAction)
    }
    
    public static func makeNextItem(targetAction: TargetAction?) -> UIBarButtonItem {
        return ._makeNextItem(targetAction: targetAction)
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


// MARK: Misc
public extension UIBarButtonItem {
    public static func makeNoTagsItem() -> UIBarButtonItem {
        return self._makeNoTagsItem()
    }
}


// MARK: // Private
// MARK: Buttons
private extension UIBarButtonItem {
    static func _makeCancelItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setTitle(NSL_("Cancel"), for: .normal)
        button.sizeToFit()
        button.tintColor = .redE62C4F
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeDeleteItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setTitle(NSL_("Delete"), for: .normal)
        button.sizeToFit()
        button.tintColor = .redE62C4F
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeOfflineItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let offlineImage: UIImage = MiscIcon.Offline.asTemplate()
        let button: UIButton = self._getNormalButton(targetAction)
        button.setBackgroundImage(offlineImage, for: .normal)
        button.sizeToFit()
        button.tintColor = .redE62C4F
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeBackItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: ImageTextButton = ImageTextButton()
        self._configure(button: button, with: targetAction)
        button.image = ArrowIcon.Left.asTemplate()
        button.text = NSL_("Back")
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeNextItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: ImageTextButton = ImageTextButton()
        self._configure(button: button, with: targetAction)
        button.image = ArrowIcon.Right.asTemplate()
        button.text = NSL_("Next")
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeEditItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setTitle(NSL_("Edit"), for: .normal)
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeNewItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setTitle(NSL_("New"), for: .normal)
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeSaveItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setTitle(NSL_("Save"), for: .normal)
        button.sizeToFit()
        button.tintColor = .blue00A7C4
        
        return UIBarButtonItem(customView: button)
    }
    
    // Helpers
    private static func _getNormalButton(_ targetAction: TargetAction?) -> UIButton {
        let button: UIButton = UIButton(type: .system)
        self._configure(button: button, with: targetAction)
        return button
    }
    
    private static func _configure(button: UIButton, with targetAction: TargetAction?) {
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.isExclusiveTouch = true
        button.setTitleColor(.gray999999, for: .disabled)
        
        if let (target, action) = targetAction {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
    }
}


// MARK: Misc
private extension UIBarButtonItem {
    static func _makeNoTagsItem() -> UIBarButtonItem {
        let noTagsLabel: UILabel = UILabel()
        noTagsLabel.textColor = .gray555555
        noTagsLabel.text = NSL_("No tags found")
        noTagsLabel.sizeToFit()
        return UIBarButtonItem(customView: noTagsLabel)
    }
}
