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
    // Setters
    func setTitle(_ title: String) {
        self._label.text = title
    }
    
    func setTitleColor(_ color: UIColor) {
        self._setTitleColor(color)
    }
    
    func setTitleFont(_ font: UIFont) {
        self._label.font = font
    }
}


// MARK: Class Declaration
class DateCell: UICollectionViewCell {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    // Common Init
    private func _init() {
        self.contentView.addSubview(self._label)
    }
    
    // Static Constants
    static let reuseIdentifier: String = "DateCellReuseIdentifier"
    
    // Private Lazy Variables
    private lazy var _label: UILabel = self._createLabel()
    
    // Private Variables
    private var _backupTitleColor: UIColor = .black
    
    // Layout Overrides
    override func layoutSubviews() {
        self._label.size = self.size
    }
    
    // isHighlighted / isSelected Overrides
    override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set { self._setIsHighlighted(newValue) }
    }
    
    override var isSelected: Bool {
        get { return super.isSelected }
        set { self._setIsSelected(newValue) }
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension DateCell {
    func _createLabel() -> UILabel {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.text = "31"
        return label
    }
}


// MARK: Computed Variables
private extension DateCell {
    func _setIsHighlighted(_ highlighted: Bool) {
        guard highlighted != super.isHighlighted else { return }
        super.isHighlighted = highlighted
        self.backgroundColor = self._backgroundColorForState(highlighted: highlighted)
        self._label.textColor = self._textColorForState(highlighted: highlighted)
    }
    
    func _setIsSelected(_ selected: Bool) {
        guard selected != super.isSelected else { return }
        self.backgroundColor = self._backgroundColorForState(selected: selected)
        self._label.textColor = self._textColorForState(selected: selected)
        super.isSelected = selected
    }
    
    func _setTitleColor(_ color: UIColor) {
        self._backupTitleColor = color
        self._label.textColor = self._textColorForState()
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
