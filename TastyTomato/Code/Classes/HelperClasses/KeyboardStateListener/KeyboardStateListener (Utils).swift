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
public protocol KeyboardDismissalHandler: class {
    static var keyboardDismissalBehaviour: KeyboardDismissalBehaviour { get }
    var keyboardDismissalBehaviour: KeyboardDismissalBehaviour? { get }
}


// MARK: Default Value Extension
extension KeyboardDismissalHandler {
    public static var keyboardDismissalBehaviour: KeyboardDismissalBehaviour {
        return .dismissWithoutPassthrough
    }
    
    public var keyboardDismissalBehaviour: KeyboardDismissalBehaviour? {
        return nil
    }
}


// MARK: - KeyboardDismissalBehaviour
public enum KeyboardDismissalBehaviour {
    case dismissWithoutPassthrough
    case passthroughAndDismiss
    case passthroughWithoutDismiss
}


// MARK: - UIView: KeyboardDismissalHandler
extension UIView: KeyboardDismissalHandler {}


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
