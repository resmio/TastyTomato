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
    
    func setBackgroundColor(_ color: @escaping () -> UIColor, for state: State) {
        self._setBackgroundColor(color, for: state)
    }
    
    func setTitleColor(_ color: @escaping () -> UIColor, for state: State) {
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
        self.setColorAdjustment(self._adjustColors)
        self.contentView.addSubview(self._label)
    }
    
    // Static Constants
    static let reuseIdentifier: String = "DateCellReuseIdentifier"
    
    // Private Lazy Variables
    private lazy var _label: UILabel = self._createLabel()
    
    // Private Variables
    private var _backgroundColors: [State: () -> UIColor] = [
        .normal: { ColorScheme.background.default },
        .highlighted: { ColorScheme.background.selectedDay.withAlpha(0.5) },
        .selected: { ColorScheme.background.selectedDay }
    ]
    
    private var _titleColors: [State: () -> UIColor] = [
        .normal: { .black },
        .highlighted: { .white },
        .selected: { .white }
    ]
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
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


// MARK: Layout Override Implementations
private extension DateCell {
    func _layoutSubviews() {
        super.layoutSubviews()
        self._label.size = self.size
    }
}


// MARK: isSelected / isHighlighted Override Implementations
private extension DateCell {
    func _setIsHighlighted(_ highlighted: Bool) {
        guard highlighted != super.isHighlighted else { return }
        super.isHighlighted = highlighted
        self.adjustColors()
    }
    
    func _setIsSelected(_ selected: Bool) {
        guard selected != super.isSelected else { return }
        super.isSelected = selected
        self.adjustColors()
    }
}


// MARK: Setter Implementations
private extension DateCell {
    func _setTitleColor(_ color: @escaping () -> UIColor, for state: State) {
        self._titleColors[state] = color
        if state == self._state {
            self.adjustColors()
        }
    }
    
    func _setBackgroundColor(_ color: @escaping () -> UIColor, for state: State) {
        self._backgroundColors[state] = color
        if state == self._state {
            self.adjustColors()
        }
    }
}


// MARK: Update Colors
private extension DateCell {
    func _adjustColors(_ view: UIView) {
        guard let cell: DateCell = view as? DateCell else { return }
        let state: State = cell._state
        cell.backgroundColor = cell._backgroundColors[state]?()
        cell._label.textColor = cell._titleColors[state]?()
    }
}
