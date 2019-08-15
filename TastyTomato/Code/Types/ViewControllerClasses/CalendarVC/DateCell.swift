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
    enum State: Hashable {
        case normal, highlighted, selected
    }
    
    // Setters
    func setTitle(_ title: String) {
        self._label.text = title
    }
    
    func setTitleFont(_ font: UIFont) {
        self._label.font = font
    }
    
    func setBackgroundColor(_ color: UIColor, for state: State) {
        self._setBackgroundColor(color, for: state)
    }
    
    func setTitleColor(_ color: UIColor, for state: State) {
        self._setTitleColor(color, for: state)
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
    private var _backgroundColors: [State: UIColor] = [
        .normal: .white,
        .highlighted: UIColor.blue00A7C4.withAlpha(0.5),
        .selected: .blue00A7C4
    ]
    
    private var _titleColors: [State: UIColor] = [
        .normal: .black,
        .highlighted: .white,
        .selected: .white
    ]
    
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
    var _state: State {
        return self.isSelected ? .selected : (self.isHighlighted ? .highlighted : .normal)
    }
}


// MARK: Setter Implementations
private extension DateCell {
    func _setTitleColor(_ color: UIColor, for state: State) {
        self._titleColors[state] = color
        if state == self._state {
            self._updateColors()
        }
    }
    
    func _setBackgroundColor(_ color: UIColor, for state: State) {
        self._backgroundColors[state] = color
        if state == self._state {
            self._updateColors()
        }
    }
}


// MARK: isSelected / isHighlighted Override Implementations
private extension DateCell {
    func _setIsHighlighted(_ highlighted: Bool) {
        guard highlighted != super.isHighlighted else { return }
        super.isHighlighted = highlighted
        self._updateColors()
    }
    
    func _setIsSelected(_ selected: Bool) {
        guard selected != super.isSelected else { return }
        super.isSelected = selected
        self._updateColors()
    }
}


// MARK: Update Colors
private extension DateCell {
    func _updateColors() {
        let state: State = self._state
        self.backgroundColor = self._backgroundColors[state]
        self._label.textColor = self._titleColors[state]
    }
}
