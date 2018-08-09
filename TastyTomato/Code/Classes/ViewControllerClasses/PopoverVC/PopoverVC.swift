//
//  PopoverVC.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 09.08.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: - PopoverPresentationDelegate
@objc public protocol PopoverPresentationDelegate: class {
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
    public var presentationDelegate: PopoverPresentationDelegate? {
        get { return self._presentationDelegate }
        set { self._presentationDelegate = newValue }
    }
    
    @objc public var sourceView: UIView? {
        get { return self._sourceView }
        set { self._sourceView = newValue }
    }
    
    @objc public var sourceRect: CGRect {
        get { return self._sourceRect }
        set { self._sourceRect = newValue }
    }
    
    @objc public var barButtonItem: UIBarButtonItem? {
        get { return self._barButtonItem }
        set { self._barButtonItem = newValue }
    }
    
    @objc public var permittedArrowDirections: UIPopoverArrowDirection {
        get { return self._permittedArrowDirections }
        set { self._permittedArrowDirections = newValue }
    }
    
    public var inset: CGFloat {
        get { return self._inset }
        set{ self._inset = newValue }
    }
    
    public var contentView: UIView? {
        get { return self._contentView }
        set { self._contentView = newValue }
    }
    
    public var backgroundColor: UIColor? {
        get { return self._backgroundColor }
        set { self._backgroundColor = newValue }
    }
    
    public var dimsBackground: Bool {
        get { return self._dimsBackground }
        set { self._dimsBackground = newValue }
    }
    
    public var displaysBorderShadow: Bool {
        get { return self._displaysBorderShadow }
        set { self._displaysBorderShadow = newValue }
    }
    
    public var passthroughViews: [UIView] {
        get { return self._passthroughViews }
        set { self._passthroughViews = newValue }
    }

    public func updateContentSize() {
        self._updateContentSize()
    }
    
    public func present(from viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self._present(
            from: viewController,
            animated: animated,
            completion: completion
        )
    }
}


// MARK: Class Declaration
open class PopoverVC: UIViewController {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("PopoverVC does not support NSCoding!")
    }
    
    // Init
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
    }
    
    // Private Weak Variables
    private weak var _presentationDelegate: PopoverPresentationDelegate?
    private weak var _sourceView: UIView?
    private weak var _barButtonItem: UIBarButtonItem?
    
    // Private Variables
    private var __inset: CGFloat = 15
    private var __contentView: UIView?
    private var _backgroundColor: UIColor?
    private var _sourceRect: CGRect = .zero
    private var _permittedArrowDirections: UIPopoverArrowDirection = .any
    private var _dimsBackground: Bool = true
    private var _displaysBorderShadow: Bool = true
    private var _passthroughViews: [UIView] = []
    
    
    // View Lifecycle Overrides
    override open func loadView() {
        self.view = PopoverContainerView()
    }
    
    override open func viewDidLayoutSubviews() {
        self._viewDidLayoutSubviews()
    }
    
    // Readonly Overridable
    open var defaultBackgroundColor: UIColor {
        return .white
    }
}


// MARK: Delegates / DataSources
// MARK: UIPopoverPresentationControllerDelegate
extension PopoverVC: UIPopoverPresentationControllerDelegate {
    public func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        self.presentationDelegate?.prepareToPresent?(self)
    }
    
    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return self.presentationDelegate?.shouldDismiss?(self) ?? true
    }
    
    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.presentationDelegate?.didDismiss?(self)
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension PopoverVC {
    var _contentView: UIView? {
        get { return self.__contentView }
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
        get { return self.__inset }
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


// MARK: Update Content Size
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
        class _BGView: PopoverBackgroundView {
            override class var backgroundColor: UIColor {
                get { return self._backgroundColor }
                set { self._backgroundColor = newValue }
            }
            
            override class var dimsBackground: Bool {
                get { return self._dimsBackground }
                set { self._dimsBackground = newValue }
            }
            
            override class var displaysBorderShadow: Bool {
                get { return self._displaysBorderShadow }
                set { self._displaysBorderShadow = newValue }
            }
            
            private static var _backgroundColor: UIColor = .white
            private static var _dimsBackground: Bool = true
            private static var _displaysBorderShadow: Bool = true
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
