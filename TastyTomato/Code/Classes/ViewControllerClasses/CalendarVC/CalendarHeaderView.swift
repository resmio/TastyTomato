//
//  CalendarHeaderView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 04.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: Interface
// MARK: Class Declaration
class CalendarHeaderView: UIView {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._addSubviews()
    }
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._addSubviews()
    }
    
    // Private Lazy Variables
    fileprivate lazy var _leftArrowButton: UIButton = self._createLeftArrowButton()
    fileprivate lazy var _monthNameYearLabel: UILabel = self._createMonthNameYearLabel()
    fileprivate lazy var _rightArrowButton: UIButton = self._createRightArrowButton()
    fileprivate lazy var _dayNamesView: UIStackView = self._createDayNamesView()
    
    // Layout Overrides
    override func layoutSubviews() {
        self._layoutSubviews()
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarHeaderView {
    func _createLeftArrowButton() -> UIButton {
        let leftArrowButton: UIButton = UIButton(type: .system)
        leftArrowButton.setImage(ArrowIcon.Left.asTemplate(), for: .normal)
        return leftArrowButton
    }
    
    func _createMonthNameYearLabel() -> UILabel {
        let monthNameYearLabel: UILabel = UILabel()
        monthNameYearLabel.text = "Month Year"
        return monthNameYearLabel
    }
    
    func _createRightArrowButton() -> UIButton {
        let rightArrowButton: UIButton = UIButton(type: .system)
        rightArrowButton.setImage(ArrowIcon.Right.asTemplate(), for: .normal)
        return rightArrowButton
    }
    
    func _createDayNamesView() -> UIStackView {
        let dayNamesView: UIStackView = UIStackView()
        return dayNamesView
    }
}


// MARK: Layout Override Implementations
private extension CalendarHeaderView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}


// MARK: Add Subviews
private extension CalendarHeaderView {
    func _addSubviews() {
        self.addSubview(self._leftArrowButton)
        self.addSubview(self._monthNameYearLabel)
        self.addSubview(self._rightArrowButton)
        self.addSubview(self._dayNamesView)
    }
}
