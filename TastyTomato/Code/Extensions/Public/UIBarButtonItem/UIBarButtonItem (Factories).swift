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
    typealias TargetAction = (target: AnyObject, action: Selector)
    
    static func makeCancelItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeCancelItem(targetAction: targetAction)
    }
    
    static func makeDeleteItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeDeleteItem(targetAction: targetAction)
    }
    
    static func makeOfflineItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeOfflineItem(targetAction: targetAction)
    }
    
    static func makeBackItem(targetAction: TargetAction?) -> UIBarButtonItem {
        return ._makeBackItem(targetAction: targetAction)
    }
    
    static func makeNextItem(targetAction: TargetAction?) -> UIBarButtonItem {
        return ._makeNextItem(targetAction: targetAction)
    }
    
    static func makeEditItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeEditItem(targetAction: targetAction)
    }
    
    static func makeNewItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeNewItem(targetAction: targetAction)
    }
    
    static func makeSaveItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeSaveItem(targetAction: targetAction)
    }
    
    static func makeDoneItem(targetAction: TargetAction? = nil) -> UIBarButtonItem {
        return ._makeDoneItem(targetAction: targetAction)
    }
}


// MARK: Misc
public extension UIBarButtonItem {
    static func makeNoTagsItem() -> UIBarButtonItem {
        return self._makeNoTagsItem()
    }
}


// MARK: // Private
// MARK: Buttons
private extension UIBarButtonItem {
    static func _makeCancelItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setColorAdjustment({
            guard let btn: UIButton = $0 as? UIButton else { return }
            let color: UIColor = ColorScheme.text.cancelButton
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(color.withAlpha(0.5), for: .highlighted)
        })
        button.setTitle(NSL_("Cancel"), for: .normal)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeDeleteItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setColorAdjustment({
            guard let btn: UIButton = $0 as? UIButton else { return }
            let color: UIColor = ColorScheme.text.deleteButton
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(color.withAlpha(0.5), for: .highlighted)
        })
        button.setTitle(NSL_("Delete"), for: .normal)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeOfflineItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let offlineImage: UIImage = MiscIcon.Offline.asTemplate()
        let button: UIButton = self._getNormalButton(targetAction)
        button.setBackgroundImage(offlineImage, for: .normal)
        button.setColorAdjustment({ $0.tintColor = ColorScheme.lines.offlineIcon })
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeBackItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: ImageTextButton = ImageTextButton()
        self._configure(button: button, with: targetAction)
        
        let icon: UIImage = ArrowIcon.Left.asTemplate()
        button.setColorAdjustment({
            guard let btn: ImageTextButton = $0 as? ImageTextButton else { return }
            let color: UIColor = ColorScheme.text.backButton
            let highlightedColor: UIColor = color.withAlpha(0.5)
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(highlightedColor, for: .highlighted)
            btn.setImage(icon.withTint(color: color), for: .normal)
            btn.setImage(icon.withTint(color: highlightedColor), for: .highlighted)
        })
        
        button.text = NSL_("Back")
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeNextItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: ImageTextButton = ImageTextButton()
        self._configure(button: button, with: targetAction)
        button.text = NSL_("Next")
        button.sizeToFit()
        button.imageAnchoring = .right
        
        let icon: UIImage = ArrowIcon.Right.asTemplate()
        button.setColorAdjustment({
            guard let btn: ImageTextButton = $0 as? ImageTextButton else { return }
            let color: UIColor = ColorScheme.text.backButton
            let highlightedColor: UIColor = color.withAlpha(0.5)
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(highlightedColor, for: .highlighted)
            btn.setImage(icon.withTint(color: color), for: .normal)
            btn.setImage(icon.withTint(color: highlightedColor), for: .highlighted)
        })
        
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeEditItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setColorAdjustment({
            guard let btn: UIButton = $0 as? UIButton else { return }
            let color: UIColor = ColorScheme.text.editButton
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(color.withAlpha(0.5), for: .highlighted)
        })
        button.setTitle(NSL_("Edit"), for: .normal)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeNewItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setColorAdjustment({
            guard let btn: UIButton = $0 as? UIButton else { return }
            let color: UIColor = ColorScheme.text.newButton
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(color.withAlpha(0.5), for: .highlighted)
        })
        button.setTitle(NSL_("New"), for: .normal)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeSaveItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setColorAdjustment({
            guard let btn: UIButton = $0 as? UIButton else { return }
            let color: UIColor = ColorScheme.text.saveButton
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(color.withAlpha(0.5), for: .highlighted)
        })
        button.setTitle(NSL_("Save"), for: .normal)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    static func _makeDoneItem(targetAction: TargetAction?) -> UIBarButtonItem {
        let button: UIButton = self._getNormalButton(targetAction)
        button.setColorAdjustment({
            guard let btn: UIButton = $0 as? UIButton else { return }
            let color: UIColor = ColorScheme.text.doneButton
            btn.setTitleColor(color, for: .normal)
            btn.setTitleColor(color.withAlpha(0.5), for: .highlighted)
        })
        button.setTitle(NSL_("Done"), for: .normal)
        button.sizeToFit()
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
        button.titleLabel?.font = .m
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
