//
//  KeyboarStateListener.swift
//  TastyTomato
//
//  Created by Jan Nash (privat) on 01.03.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
public extension KeyboardStateListener {
    public static var isEnabled: Bool {
        get { return self._shared._isEnabled }
        set { newValue ? self._shared._enable() : self._shared._disable() }
    }
    
    // The minimum spacing between keyboard and textField.
    // Changes will be applied the next time the keyboard is shown.
    public static var minimumSpacing: CGFloat {
        get { return self._shared._minimumSpacing }
        set { self._shared._minimumSpacing = newValue }
    }
}


// MARK: Class Declaration
public class KeyboardStateListener: NSObject {
    // Private Init
    private override init() {}
    
    // Private Singleton
    private static let _shared: KeyboardStateListener = KeyboardStateListener()
    
    // Private Weak Variables
    private weak var _activeTextInputView: UIView?
    
    // Private Variables
    private var _isEnabled: Bool = false
    private var _minimumSpacing: CGFloat = 0
    private var _keyboardIsVisible: Bool? = false
    private var _keyboardFrame: CGRect?
    private var _animationDuration: TimeInterval?
    private var _animationCurve: UIView.AnimationOptions?
    private var _dismissKeyboardRecognizer: DismissKeyboardRecognizer?
}


// MARK: Protocol Conformances
// MARK: UIGestureRecognizerDelegate
extension KeyboardStateListener: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self._dismissalBehaviourFor(touch: touch) == .dismissWithoutPassthrough
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension KeyboardStateListener {
    var _keyWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }
}


// MARK: Enable / Disable
private extension KeyboardStateListener {
    func _enable() {
        guard !self._isEnabled else { return }
        
        self._registerForAllNotifications()
        self._isEnabled = true
    }
    
    func _disable() {
        guard self._isEnabled else { return }
        
        self._unregisterFromAllNotifications()
        self._resetWindow()
        self._removeKeyboardDismissRecognizer()
        
        self._activeTextInputView = nil
        self._keyboardIsVisible = nil
        self._keyboardFrame = nil
        
        self._isEnabled = false
    }
}


// MARK: Register to/Unregister from Notifications
private extension KeyboardStateListener {
    func _registerForAllNotifications() {
        self._registerForKeyboardNotifications()
        self._registerForTextFieldNotifications()
        self._registerForTextViewNotifications()
    }
    
    func _unregisterFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Private Helpers
    private func _registerForKeyboardNotifications() {
        self._observe([
            (NSNotification.Name.UIKeyboardWillShow, #selector(_keyboardWillShow(_:))),
            (NSNotification.Name.UIKeyboardDidShow, #selector(_keyboardDidShow(_:))),
            (NSNotification.Name.UIKeyboardWillHide, #selector(_keyboardWillHide(_:))),
            (NSNotification.Name.UIKeyboardDidHide, #selector(_keyboardDidHide(_:))),
        ])
    }
    
    private func _registerForTextFieldNotifications() {
        self._observe([
            (NSNotification.Name.UITextFieldTextDidBeginEditing, #selector(_textInputViewDidBeginEditing(_:))),
            (NSNotification.Name.UITextFieldTextDidChange, #selector(_textInputViewTextDidChange(_:))),
            (NSNotification.Name.UITextFieldTextDidEndEditing, #selector(_textInputViewDidEndEditing(_:))),
        ])
    }
    
    private func _registerForTextViewNotifications() {
        self._observe([
            (NSNotification.Name.UITextViewTextDidBeginEditing, #selector(_textInputViewDidBeginEditing(_:))),
            (NSNotification.Name.UITextViewTextDidChange, #selector(_textInputViewTextDidChange(_:))),
            (NSNotification.Name.UITextViewTextDidEndEditing, #selector(_textInputViewDidEndEditing(_:))),
        ])
    }
    
    private func _observe(_ selectorsWithNames: [(NSNotification.Name, Selector)]) {
        selectorsWithNames.forEach({ NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil) })
    }
}


// MARK: Keyboard Notification Target Selectors
private extension KeyboardStateListener {
    @objc func _keyboardWillShow(_ notification: Notification) {
        self._addDismissKeyboardRecognizer()
        self._setKeyboardFrame(from: notification)
        self._setAnimationProperties(from: notification)
        self._adjustWindowOffset()
    }
    
    @objc func _keyboardDidShow(_ notification: Notification) {
        self._keyboardIsVisible = true
    }
    
    @objc func _keyboardWillHide(_ notification: Notification) {
        self._resetWindow()
        self._removeKeyboardDismissRecognizer()
    }
    
    @objc func _keyboardDidHide(_ notification: Notification) {
        self._removeKeyboardDismissRecognizer()
        self._keyboardIsVisible = false
        self._keyboardFrame = nil
    }
}


// MARK: TextInput Notification Target Selectors
private extension KeyboardStateListener {
    @objc func _textInputViewDidBeginEditing(_ notification: Notification) {
        guard let textInputView: UIView = notification.object as? UIView else { return }
        self._activeTextInputView = textInputView
        self._addFakeAccessoryViewIfNecessary(toView: textInputView)
        self._adjustWindowOffset()
    }
    
    @objc func _textInputViewTextDidChange(_ notification: Notification) {
        self._adjustWindowOffset()
    }
    
    @objc func _textInputViewDidEndEditing(_ notification: Notification) {
        self._activeTextInputView = nil
        self._resetWindow()
    }
    
    // Private Helper
    private func _addFakeAccessoryViewIfNecessary(toView view: UIView /*UITextField or UITextView*/) {
        // Normally, the order of fired notifications is:
        //
        // *- UIKeyboardWillShowNotification (if the input view is a textView, this is fired first)
        // - UITextFieldTextDidBeginEditingNotification / UITextViewTextDidBeginEditingNotification
        // *- UIKeyboardWillShowNotification (if the input view is a textField, this is fired second)
        // - UIKeyboardDidShowNotification
        // - UIKeyboardWillHideNotification
        // - UITextFieldTextDidEndEditingNotification / UITextViewTextDidEndEditingNotification
        // - UIKeyboardDidHideNotification
        //
        // This does not only work great for our purposes, it is also logical.
        //
        // Unfortunately, if a Hardware-keyboard is attached, the order of fired notifications is:
        //
        // - UIKeyboardWillHideNotification
        // - UITextFieldTextDidBeginEditingNotification / UITextViewTextDidBeginEditingNotification
        // - UIKeyboardDidHideNotification
        // - UIKeyboardWillHideNotification
        // - UITextFieldTextDidEndEditingNotification / UITextViewTextDidEndEditingNotification
        // - UIKeyboardDidHideNotification
        //
        // This is not only illogical, it also kills the use of this class...
        //
        // Fortunately, there's a way to get the willShow and didShow notifications back:
        // When the TextField / TextView has an inputAccessoryView, the notifications get sent
        // in the normal way, even if the inputAccessoryView has a zero-frame.
        //
        if view.inputAccessoryView != nil { return }
        if let textField: UITextField = view as? UITextField {
            textField.inputAccessoryView = UIView(frame: .zero)
        } else if let textView: UITextView = view as? UITextView {
            textView.inputAccessoryView = UIView(frame: .zero)
        }
        view.reloadInputViews()
    }
}


// MARK: Parse Notifications
private extension KeyboardStateListener {
    func _setKeyboardFrame(from notification: Notification) {
        let userInfoDict: NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let keyboardFrameValue: NSValue = userInfoDict.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        self._keyboardFrame = keyboardFrameValue.cgRectValue
    }
    
    func _setAnimationProperties(from notification: Notification) {
        let userInfoDict: NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        
        let animationDurationValue: NSNumber = userInfoDict.object(forKey: UIKeyboardAnimationDurationUserInfoKey) as! NSNumber
        self._animationDuration = TimeInterval(animationDurationValue.doubleValue)
        
        let animationCurveValue: NSNumber = userInfoDict.object(forKey: UIKeyboardAnimationCurveUserInfoKey) as! NSNumber
        self._animationCurve = UIView.AnimationOptions(rawValue: animationCurveValue.uintValue)
    }
}


// MARK: Adjust Window Y Offset to assure TextInput Visibility
private extension KeyboardStateListener {
    func _adjustWindowOffset() {
        // Since the keyboardWillShow and the textView/textField-didBeginEditing notifications
        // can come in in both orders, we have to check if both came in already.
        guard let textInputView: UIView = self._activeTextInputView else { return }
        guard let keyboardFrame: CGRect = self._keyboardFrame else { return }
        let keyWindow: UIWindow = self._keyWindow
        
        // Relative to the window because we're doing the evasive maneuvers
        // with the windows origin.y value.
        let textInputViewTop: CGFloat = textInputView.convert(.zero, to: nil).y
        let textInputViewBottom: CGFloat = textInputViewTop + textInputView.height
        
        // Relative to the screen
        let currentWindowOffset: CGFloat = keyWindow.yOffset
        
        // The keyboard frame is always relative to the screen
        let globalKeyboardFrameTop: CGFloat = keyboardFrame.top + currentWindowOffset
        let globalTextInputViewBottom: CGFloat = textInputViewBottom + currentWindowOffset
        
        let minimumSpacing: CGFloat = self._minimumSpacing
        let currentSpacing: CGFloat = globalKeyboardFrameTop - globalTextInputViewBottom
        
        let requiredYOffset: CGFloat = currentSpacing - minimumSpacing
        guard requiredYOffset < 0 else { return }
        
        textViewScope: if let textView: UITextView = textInputView as? UITextView {
            let height: CGFloat = textView.height
            let minimumHeight: CGFloat = textView.minimumHeight
            let possibleHeightChange: CGFloat = height - minimumHeight
            
            guard possibleHeightChange > 0 else { break textViewScope }
            
            if possibleHeightChange >= abs(requiredYOffset) {
                self._animate() {
                    textInputView.setTempHeight(requiredYOffset + height)
                }
            } else {
                self._animate() {
                    textInputView.setTempHeight(minimumHeight)
                    keyWindow.setTempY(requiredYOffset + possibleHeightChange)
                }
            }
            
            return
        }
        
        self._animate() {
            keyWindow.setTempY(requiredYOffset)
        }
    }
    
    // Private Helper
    private func _animate(_ animations: @escaping () -> Void) {
        UIView.animate(
            withDuration: max(0.3, self._animationDuration ?? 0.3),
            delay: 0,
            options: self._animationCurve ?? [],
            animations: animations,
            completion: nil
        )
    }
}


// MARK: Reset Window
private extension KeyboardStateListener {
    func _resetWindow() {
        self._keyWindow.resetY()
        self._activeTextInputView?.resetHeight()
        self._animationDuration = nil
        self._animationCurve = nil
    }
}


// MARK: TapRecognizer
private extension KeyboardStateListener {
    func _addDismissKeyboardRecognizer() {
        guard self._dismissKeyboardRecognizer == nil else { return }
        
        let dismissRecognizer: DismissKeyboardRecognizer = DismissKeyboardRecognizer()
        dismissRecognizer.addTarget(
            self,
            action: #selector(_keyboardDismissRecognizerTapped(_:))
        )
        dismissRecognizer.delegate = self
        
        self._dismissKeyboardRecognizer = dismissRecognizer
        self._keyWindow.addGestureRecognizer(self._dismissKeyboardRecognizer!)
    }
    
    func _removeKeyboardDismissRecognizer() {
        guard let dismissRecognizer: DismissKeyboardRecognizer = self._dismissKeyboardRecognizer else { return }
        self._keyWindow.removeGestureRecognizer(dismissRecognizer)
        self._dismissKeyboardRecognizer = nil
    }
}


// MARK: TapRecognizer Target Selector
private extension KeyboardStateListener {
    @objc func _keyboardDismissRecognizerTapped(_ recognizer: DismissKeyboardRecognizer) {
        guard let inputView: UIView = self._activeTextInputView else { return }
        
        switch self._dismissalBehaviourFor(recognizer: recognizer) {
        case .passthroughWithoutDismiss:
            return
        case .dismissWithoutPassthrough, .passthroughAndDismiss:
            // ???:
            let location: CGPoint = recognizer.location(in: inputView)
            if !inputView.point(inside: location, with: nil) {
                inputView.endEditing(false)
            }
        }
    }
}


// MARK: Helper Functions
private extension KeyboardStateListener {
    func _dismissalBehaviourFor(touch: UITouch? = nil, recognizer: UIGestureRecognizer? = nil) -> KeyboardDismissalBehaviour {
        guard let handler: KeyboardDismissalHandler = self._viewFor(touch, recognizer) else {
            return .dismissWithoutPassthrough
        }
        
        // Instance behaviour handling is always prioritized over class behaviour handling
        return handler.keyboardDismissalBehaviour ?? type(of: handler).keyboardDismissalBehaviour
    }
    
    // Private Helpers
    private func _viewFor(_ touch: UITouch?, _ gestureRecognizer: UIGestureRecognizer?) -> KeyboardDismissalHandler? {
        guard let point: CGPoint = self._pointFor(touch, gestureRecognizer) else { return nil }
        return self._keyWindow.hitTest(point, with: nil) as? KeyboardDismissalHandler
    }
    
    private func _pointFor(_ touch: UITouch?, _ gestureRecognizer: UIGestureRecognizer?) -> CGPoint? {
        return touch?.location(in: nil) ?? gestureRecognizer?.location(in: nil)
    }
}
