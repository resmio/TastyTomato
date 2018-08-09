//
//  PopoverVC.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 09.08.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: - PopoverPresentationDelegate
@objc protocol PopoverPresentationDelegate: class {
    @objc optional func prepareToPresent(_ popover: PopoverVC)
    @objc optional func shouldDismiss(_ popover: PopoverVC) -> Bool
    @objc optional func didDismiss(_ popover: PopoverVC)
}


// MARK: - PopoverContainerView
class PopoverContainerView: UIView {}


// MARK: - PopoverVC
// MARK: Interface
extension PopoverVC {
    // ReadWrite
    var presentationDelegate: PopoverPresentationDelegate? {
        get {
            return self._presentationDelegate
        }
        set(newPresentationDelegate) {
            self._presentationDelegate = newPresentationDelegate
        }
    }
    
    @objc var sourceView: UIView? {
        get {
            return self._sourceView
        }
        set(newSourceView) {
            self._sourceView = newSourceView
        }
    }
    
    @objc var sourceRect: CGRect {
        get {
            return self._sourceRect
        }
        set(newSourceRect) {
            self._sourceRect = newSourceRect
        }
    }
    
    @objc var barButtonItem: UIBarButtonItem? {
        get {
            return self._barButtonItem
        }
        set(newBarButtonItem) {
            self._barButtonItem = newBarButtonItem
        }
    }
    
    @objc var permittedArrowDirections: UIPopoverArrowDirection {
        get {
            return self._permittedArrowDirections
        }
        set(newPermittedArrowDirections) {
            self._permittedArrowDirections = newPermittedArrowDirections
        }
    }
    
    var inset: CGFloat {
        get {
            return self._inset
        }
        set(newInset) {
            self._inset = newInset
        }
    }
    
    var contentView: UIView? {
        get {
            return self._contentView
        }
        set(newContentView) {
            self._contentView = newContentView
        }
    }
    
    var backgroundColor: UIColor? {
        get {
            return self._backgroundColor
        }
        set(newBackgroundColor) {
            self._backgroundColor = newBackgroundColor
        }
    }
    
    var dimsBackground: Bool {
        get {
            return self._dimsBackground
        }
        set(newDimsBackground) {
            self._dimsBackground = newDimsBackground
        }
    }
    
    var displaysBorderShadow: Bool {
        get {
            return self._displaysBorderShadow
        }
        set(newDisplaysBorderShadow) {
            self._displaysBorderShadow = newDisplaysBorderShadow
        }
    }
    
    var passthroughViews: [UIView] {
        get {
            return self._passthroughViews
        }
        set(newPassthroughViews) {
            self._passthroughViews = newPassthroughViews
        }
    }
    
    // To be used by subclasses when they change
    // the size of the contentView without setting it
    // See RAOfflinePopover for an example
    func updateContentSize() {
        self._updateContentSize()
    }
}


// MARK: Present / Dismiss
@objc extension PopoverVC {
    func present(from viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self._present(
            from: viewController,
            animated: animated,
            completion: completion
        )
    }
}


// MARK: Class Declaration
class PopoverVC: UIViewController {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        fatalError("PopoverVC does not support NSCoding!")
    }
    
    // Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
    }
    
    // Private Weak Variables
    fileprivate weak var _presentationDelegate: PopoverPresentationDelegate?
    fileprivate weak var _sourceView: UIView?
    fileprivate weak var _barButtonItem: UIBarButtonItem?
    
    // Private Variables
    fileprivate var __inset: CGFloat = 15
    fileprivate var __contentView: UIView?
    fileprivate var _backgroundColor: UIColor?
    fileprivate var _sourceRect: CGRect = .zero
    fileprivate var _permittedArrowDirections: UIPopoverArrowDirection = .any
    fileprivate var _dimsBackground: Bool = true
    fileprivate var _displaysBorderShadow: Bool = true
    fileprivate var _passthroughViews: [UIView] = []
    
    
    // View Lifecycle Overrides
    override func loadView() {
        self.view = PopoverContainerView()
    }
    
    override func viewDidLayoutSubviews() {
        self._viewDidLayoutSubviews()
    }
    
    // Readonly Overridable
    var defaultBackgroundColor: UIColor {
        return .white
    }
}


// MARK: Delegates / DataSources
// MARK: UIPopoverPresentationControllerDelegate
extension PopoverVC: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        self.presentationDelegate?.prepareToPresent?(self)
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return self.presentationDelegate?.shouldDismiss?(self) ?? true
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.presentationDelegate?.didDismiss?(self)
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension PopoverVC {
    var _contentView: UIView? {
        get {
            return self.__contentView
        }
        set(newContentView) {
            guard newContentView != self.__contentView else { return }
            self.__contentView?.removeFromSuperview()
            self.__contentView = newContentView
            
            if let contentView: UIView = newContentView {
                contentView.origin = CGPoint(x: self.inset, y: self.inset)
                self.view.addSubview(contentView)
            }
            
            self.updateContentSize()
        }
    }
    
    var _inset: CGFloat {
        get {
            return self.__inset
        }
        set(newInset) {
            guard newInset != self.__inset else { return }
            self.__inset = newInset
            self.contentView?.origin = CGPoint(x: newInset, y: newInset)
            self._updateContentSize()
        }
    }
}


// MARK: View Lifecycle Override Implementations
private extension PopoverVC {
    func _viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self._updateContentSize()
    }
}


// MARK: Update Content Frame
private extension PopoverVC {
    func _updateContentSize() {
        let inset: CGFloat = self.inset
        var size: CGSize = self.__contentView?.bounds.size ?? .zero
        size.width += 2 * inset
        size.height += 2 * inset
        self.view.size = size
        self.preferredContentSize = size
    }
}


// MARK: Presentation
private extension PopoverVC {
    func _present(from viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let presentingViewController: UIViewController = self.presentingViewController {
            guard presentingViewController != viewController else {
                return
            }
            
            self.dismiss(animated: animated) {
                self.__present(from: viewController, animated: animated, completion: completion)
            }
            
            return
        }
        
        self.__present(from: viewController, animated: animated, completion: completion)
    }
    
    // Private Helpers
    private func __present(from viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        class _BGView: RAPopoverBackgroundView {
            override class var backgroundColor: UIColor {
                get {
                    return self._backgroundColor
                }
                set(newBackgroundColor) {
                    self._backgroundColor = newBackgroundColor
                }
            }
            
            override class var dimsBackground: Bool {
                get {
                    return self._dimsBackground
                }
                set(newDimsBackground) {
                    self._dimsBackground = newDimsBackground
                }
            }
            
            override class var displaysBorderShadow: Bool {
                get {
                    return self._displaysBorderShadow
                }
                set(newDisplaysBorderShadow) {
                    self._displaysBorderShadow = newDisplaysBorderShadow
                }
            }
            
            fileprivate static var _backgroundColor: UIColor = .white
            fileprivate static var _dimsBackground: Bool = true
            fileprivate static var _displaysBorderShadow: Bool = true
        }
        
        let bgViewClass: _BGView.Type = _BGView.self
        bgViewClass.backgroundColor = self.backgroundColor ?? self.defaultBackgroundColor
        bgViewClass.dimsBackground = self.dimsBackground
        bgViewClass.displaysBorderShadow = self.displaysBorderShadow
        
        let cont: UIPopoverPresentationController? = self.popoverPresentationController
        cont?.delegate = self
        cont?.popoverBackgroundViewClass = bgViewClass
        cont?.sourceView = self.sourceView ?? viewController.view
        cont?.sourceRect = self.sourceRect
        cont?.barButtonItem = self.barButtonItem
        cont?.permittedArrowDirections = self.permittedArrowDirections
        cont?.passthroughViews = self.passthroughViews
        
        viewController.present(self, animated: animated, completion: completion)
    }
}

