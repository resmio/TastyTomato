//
//  KeyboardStateListener (Utils).swift
//  TastyTomato
//
//  Created by Jan Nash (privat) on 01.03.18.
//  Copyright © 2018 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: - DismissKeyboardRecognizer
public class DismissKeyboardRecognizer: UITapGestureRecognizer {}


// MARK: - KeyboardDismissalHandler
@objc public protocol KeyboardDismissalHandler {
    static var keyboardDismissalBehaviour: KeyboardDismissalBehaviour { get }
    @objc optional var keyboardDismissalBehaviour: KeyboardDismissalBehaviour { get }
}


// MARK: - KeyboardDismissalBehaviour
@objc public enum KeyboardDismissalBehaviour: Int {
    case dismissWithoutPassthrough
    case passthroughAndDismiss
    case passthroughWithoutDismiss
}


// FIXME: Remove these extensions, they're not overridable, which makes them quite useless
// Instead, the default behaviour should be implemented as a stored class var in BaseTextField/View
// MARK: - UITextView: KeyboardDismissalHandler
extension UITextView/*: KeyboardDismissalHandler*/ {
    class var keyboardDismissalBehaviour: KeyboardDismissalBehaviour {
        return .passthroughWithoutDismiss
    }
}


// MARK: - UITextField: KeyboardDismissalHandler
extension UITextField/*: KeyboardDismissalHandler*/ {
    class var keyboardDismissalBehaviour: KeyboardDismissalBehaviour {
        return .passthroughWithoutDismiss
    }
}
