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
    @objc optional func dropDownTextFieldShouldBeginEditing(_ dropDownTextField: DropDownTextField) -> Bool
    @objc optional func dropDownTextFieldDidBeginEditing(_ dropDownTextField: DropDownTextField)
    @objc optional func dropDownTextFieldShouldEndEditing(_ dropDownTextField: DropDownTextField) -> Bool
    @objc optional func dropDownTextFieldDidEndEditing(_ dropDownTextField: DropDownTextField)
    
    @objc optional func dropDownTextField(_ dropDownTextField: DropDownTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    @objc optional func dropDownTextFieldShouldClear(_ dropDownTextField: DropDownTextField) -> Bool
    @objc optional func dropDownTextFieldShouldReturn(_ dropDownTextField: DropDownTextField) -> Bool

    // Custom Methods
    @objc optional func dropDownHeightForDropDownTextField(_ dropDownTextField: DropDownTextField) -> CGFloat
    @objc optional func dropDownTextFieldShouldShowDropDown(_ dropDownTextField: DropDownTextField) -> Bool
    @objc optional func dropDownTextFieldShouldHideDropDown(_ dropDownTextField: DropDownTextField) -> Bool
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
    
    public func showDropDown(_ animated: Bool) {
        self._showDropDown(true, animated: animated)
    }
    
    public func hideDropDown(_ animated: Bool) {
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
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._setupSubviews()
    }
    
    // Private Variable Stored Properties
    fileprivate weak var _delegate: DropDownTextFieldDelegate?
    fileprivate weak var _dataSource: DropDownTextFieldDataSource?
    
    fileprivate var _textField: BaseTextField!
    fileprivate var _tableView: UITableView!
}


// MARK: Delegate / DataSource Forwarding
extension DropDownTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldBeginEditing?(self) ?? true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldEndEditing?(self) ?? true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.delegate?.dropDownTextField?(
            self,
            shouldChangeCharactersInRange: range,
            replacementString: string
        ) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldClear?(self) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.delegate?.dropDownTextFieldShouldReturn?(self) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if self._shouldShowDropDown() {
            self.showDropDown(true)
            self._textField.layer.borderColor = UIColor.Blue00A7C4().cgColor
        }
        self.delegate?.dropDownTextFieldDidBeginEditing?(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if self._shouldHideDropDown() {
            self.hideDropDown(true)
            self._textField.layer.borderColor = UIColor.GrayDDDDDD().cgColor
        }
        self.delegate?.dropDownTextFieldDidEndEditing?(self)
    }
}

extension DropDownTextField: UITableViewDelegate {}
extension DropDownTextField: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "identifier"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        cell.size = self.size
        cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
        cell.backgroundColor = UIColor.white
        
        return cell
    }
}


// MARK: Wrapped Delegate / DataSource Methods
private extension DropDownTextField {
    func _dropDownHeight() -> CGFloat {
        let defaultHeight: CGFloat = self.height * 3
        return self.delegate?.dropDownHeightForDropDownTextField?(self) ?? defaultHeight
    }
    
    func _shouldShowDropDown() -> Bool {
        return self.delegate?.dropDownTextFieldShouldShowDropDown?(self) ?? true
    }
    
    func _shouldHideDropDown() -> Bool {
        return self.delegate?.dropDownTextFieldShouldHideDropDown?(self) ?? true
    }
}


// MARK: // Private
// MARK: Setup Subviews
private extension DropDownTextField {
    func _setupSubviews() {
        self._setupTextField()
        self._setupTableView()
    }
    
    func _setupTextField() {
        let textField: BaseTextField = BaseTextField()
        textField.frame = self.bounds
        textField.delegate = self
        
        textField.addTarget(
            self,
            action: #selector(refreshDropDown),
            for: .valueChanged
        )
        
        self._textField = textField
        self.addSubview(textField)
    }
    
    func _setupTableView() {
        let tableView: UITableView = UITableView()
        tableView.width = self.width
        tableView.top = self.height - self._textField.layer.cornerRadius
        
        tableView.layer.zPosition = CGFloat.greatestFiniteMagnitude
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderColor = UIColor.Blue00A7C4().cgColor
        tableView.layer.borderWidth = 1
        tableView.backgroundColor = UIColor.white
        
        self._tableView = tableView
        self.addSubview(tableView)
    }
}


// MARK: Update DropDown
private extension DropDownTextField {
    func _refreshDropDown() {
        self._tableView.reloadData()
        self._updateTableViewHeight()
    }
    
    func _updateTableViewHeight() {
        self._tableView.height = self._dropDownHeight()
    }
}


// MARK: Show / Hide DropDown Manually
private extension DropDownTextField {
    func _showDropDown(_ show: Bool, animated: Bool) {
        if show {
            self._tableView.reloadData()
            self.superview?.bringSubview(toFront: self)
        }
        
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            self._tableView.height = show ? self._dropDownHeight() : 0
            self._tableView.isHidden = !show
        }) 
    }
}
