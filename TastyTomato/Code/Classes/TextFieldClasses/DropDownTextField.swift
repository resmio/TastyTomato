//
//  DropDownTextField.swift
//  TastyTomato
//
//  Created by Jan Nash on 8/26/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Protocol Declaration
@objc public protocol DropDownTextFieldDelegate: class {
    // Copied and Adapted from UITextFieldDelegate
    optional func dropDownTextFieldShouldBeginEditing(dropDownTextField: DropDownTextField) -> Bool
    optional func dropDownTextFieldDidBeginEditing(dropDownTextField: DropDownTextField)
    optional func dropDownTextFieldShouldEndEditing(dropDownTextField: DropDownTextField) -> Bool
    optional func dropDownTextFieldDidEndEditing(dropDownTextField: DropDownTextField)
    
    optional func dropDownTextField(dropDownTextField: DropDownTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    optional func dropDownTextFieldShouldClear(dropDownTextField: DropDownTextField) -> Bool
    optional func dropDownTextFieldShouldReturn(dropDownTextField: DropDownTextField) -> Bool

    // Custom Methods
    optional func dropDownHeightForDropDownTextField(dropDownTextField: DropDownTextField) -> CGFloat
    optional func dropDownTextFieldShouldShowDropDown(dropDownTextField: DropDownTextField) -> Bool
    optional func dropDownTextFieldShouldHideDropDown(dropDownTextField: DropDownTextField) -> Bool
}

@objc public protocol DropDownTextFieldDataSource: class {}


// MARK: // Public
// MARK: Interface
public extension DropDownTextField {
    public var delegate: DropDownTextFieldDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    public var dataSource: DropDownTextFieldDataSource? {
        get {
            return self._dataSource
        }
        set(newDataSource) {
            self._dataSource = newDataSource
        }
    }
    
    public func showDropDown(animated: Bool) {
        self._showDropDown(true, animated: animated)
    }
    
    public func hideDropDown(animated: Bool) {
        self._showDropDown(false, animated: animated)
    }
    
    func refreshDropDown() {
        self._refreshDropDown()
    }
}


// MARK: Class Declaration
public class DropDownTextField: UIView {
    // Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("DropDownTextField does not support NSCoding")
    }
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._setupSubviews()
    }
    
    // Private Variable Stored Properties
    private weak var _delegate: DropDownTextFieldDelegate?
    private weak var _dataSource: DropDownTextFieldDataSource?
    
    private var _textField: BaseTextField!
    private var _tableView: UITableView!
}


// MARK: Delegate / DataSource Forwarding
extension DropDownTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldBeginEditing?(self) ?? true
    }
    
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldEndEditing?(self) ?? true
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return self.delegate?.dropDownTextField?(
            self,
            shouldChangeCharactersInRange: range,
            replacementString: string
        ) ?? true
    }
    
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldClear?(self) ?? true
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldReturn?(self) ?? true
    }
    
    public func textFieldDidBeginEditing(textField: UITextField) {
        if self._shouldShowDropDown() {
            self.showDropDown(true)
        }
        self.delegate?.dropDownTextFieldDidBeginEditing?(self)
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        if self._shouldHideDropDown() {
            self.hideDropDown(true)
        }
        self.delegate?.dropDownTextFieldDidEndEditing?(self)
    }
}

extension DropDownTextField: UITableViewDelegate {
    
}

extension DropDownTextField: UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "identifier"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        cell.size = self.size
        cell.textLabel?.text = "\(indexPath)"
        
        return cell
    }
}


// MARK: Wrapped Delegate / DataSource Methods
private extension DropDownTextField {
    private func _dropDownHeight() -> CGFloat {
        let defaultHeight: CGFloat = self.height * 3
        return self.delegate?.dropDownHeightForDropDownTextField?(self) ?? defaultHeight
    }
    
    private func _shouldShowDropDown() -> Bool {
        return self.delegate?.dropDownTextFieldShouldShowDropDown?(self) ?? true
    }
    
    private func _shouldHideDropDown() -> Bool {
        return self.delegate?.dropDownTextFieldShouldHideDropDown?(self) ?? true
    }
}


// MARK: // Private
// MARK: Setup Subviews
private extension DropDownTextField {
    private func _setupSubviews() {
        self._setupTextField()
        self._setupTableView()
    }
    
    private func _setupTextField() {
        let textField: BaseTextField = BaseTextField.textField_()
        textField.frame = self.bounds
        textField.delegate = self
        
        textField.addTarget(
            self,
            action: #selector(refreshDropDown),
            forControlEvents: .ValueChanged
        )
        
        self._textField = textField
        self.addSubview(textField)
    }
    
    private func _setupTableView() {
        let tableView: UITableView = UITableView()
        tableView.width = self.width
        tableView.top = self.bottom - self._textField.layer.cornerRadius
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderColor = UIColor.Blue00A7C4().CGColor
        tableView.layer.borderWidth = 1
        
        self._tableView = tableView
        self.addSubview(tableView)
    }
}


// MARK: Update DropDown
private extension DropDownTextField {
    private func _refreshDropDown() {
        self._tableView.reloadData()
        self._updateTableViewHeight()
    }
    
    private func _updateTableViewHeight() {
        self._tableView.height = self._dropDownHeight()
    }
}


// MARK: Show / Hide DropDown Manually
private extension DropDownTextField {
    private func _showDropDown(show: Bool, animated: Bool) {
        if show {
            self._tableView.reloadData()
        }
        
        UIView.animateWithDuration(animated ? 0.3 : 0) {
            self._tableView.height = show ? self._dropDownHeight() : 0
            self._tableView.hidden = !show
        }
    }
}
