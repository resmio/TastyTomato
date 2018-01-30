//
//  DateCell.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 04.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Interface
extension DateCell {
    var title: String {
        get {
            return self._label.text ?? ""
        }
        set(newTitle) {
            self._label.text = newTitle
        }
    }
    
    var titleColor: UIColor {
        get {
            return self._titleColor
        }
        set(newTitleColor) {
            self._titleColor = newTitleColor
        }
    }
    
    var titleFont: UIFont {
        get {
            return self._label.font
        }
        set(newTitleFont) {
            self._label.font = newTitleFont
        }
    }
}


// MARK: Class Declaration
class DateCell: UICollectionViewCell {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(self._label)
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self._label)
    }
    
    // Static Constants
    static let reuseIdentifier: String = "DateCellReuseIdentifier"
    
    // Private Lazy Variables
    fileprivate lazy var _label: UILabel = self._createLabel()
    
    // Private Variables
    fileprivate var _backupTitleColor: UIColor = .black
    
    // Layout Overrides
    override func layoutSubviews() {
        self._label.size = self.size
    }
    
    // isHighlighted / isSelected Overrides
    override var isHighlighted: Bool {
        get {
            return self._isHighlighted
        }
        set(newIsHighlighted) {
            self._isHighlighted = newIsHighlighted
        }
    }
    
    override var isSelected: Bool {
        get {
            return self._isSelected
        }
        set(newIsSelected) {
            self._isSelected = newIsSelected
        }
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension DateCell {
    func _createLabel() -> UILabel {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.textColor = self._backupTitleColor
        label.text = "31"
        return label
    }
}


// MARK: Computed Variables
private extension DateCell {
    var _isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set(newIsHighlighted) {
            guard newIsHighlighted != super.isHighlighted else { return }
            self.backgroundColor = self._backgroundColorForState(highlighted: newIsHighlighted)
            self._label.textColor = self._textColorForState(highlighted: newIsHighlighted)
            super.isHighlighted = newIsHighlighted
        }
    }
    
    var _isSelected: Bool {
        get {
            return super.isSelected
        }
        set(newIsSelected) {
            guard newIsSelected != super.isSelected else { return }
            self.backgroundColor = self._backgroundColorForState(selected: newIsSelected)
            self._label.textColor = self._textColorForState(selected: newIsSelected)
            super.isSelected = newIsSelected
        }
    }
    
    var _titleColor: UIColor {
        get {
            return self._label.textColor
        }
        set(newTitleColor) {
            self._backupTitleColor = newTitleColor
            self._label.textColor = self._textColorForState()
        }
    }
}


// MARK: Color Helpers
private extension DateCell {
    func _backgroundColorForState(highlighted: Bool? = nil, selected: Bool? = nil) -> UIColor {
        let highlighted: Bool = highlighted ?? self.isHighlighted
        let selected: Bool = selected ?? self.isSelected
        if highlighted {
            return UIColor.blue00A7C4.withAlpha(0.5)
        } else if selected {
            return .blue00A7C4
        } else {
            return .white
        }
    }
    
    func _textColorForState(highlighted: Bool? = nil, selected: Bool? = nil) -> UIColor {
        let highlighted: Bool = highlighted ?? self.isHighlighted
        let selected: Bool = selected ?? self.isSelected
        if highlighted || selected {
            return .white
        } else {
            return self._backupTitleColor
        }
    }
}


// MARK: Display Title in bold
private extension DateCell {
    func _displayTitleInBold(_ bold: Bool) {
        let label: UILabel = self._label
        let currentFont: UIFont = label.font
        label.font = bold ? currentFont.bold() : currentFont.normal()
    }
}
