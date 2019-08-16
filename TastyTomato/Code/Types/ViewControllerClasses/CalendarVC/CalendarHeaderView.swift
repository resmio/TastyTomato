//
//  CalendarHeaderView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 04.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: -
protocol CalendarHeaderViewDelegate: class {
    func tappedLeftArrowButton(on calendarHeaderView: CalendarHeaderView)
    func tappedRightArrowButton(on calendarHeaderView: CalendarHeaderView)
}


// MARK: -
struct CalendarHeaderViewDesign {
    var dayNamesFont: UIFont              = CalendarVCDesign.defaultDesign.dayNamesFont
    var dayNamesTextColor: () -> UIColor  = CalendarVCDesign.defaultDesign.dayNamesTextColor
}


// MARK: -
// MARK: Interface
extension CalendarHeaderView {
    // Readonly
    var titleFrame: CGRect {
        return self._titleFrame
    }
    
    // Setters
    func setDelegate(_ delegate: CalendarHeaderViewDelegate?) {
        self._delegate = delegate
    }
    
    func setDesign(_ design: CalendarHeaderViewDesign) {
        self._setDesign(design)
    }
}


// MARK: Class Declaration
class CalendarHeaderView: UIView {
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
        self.backgroundColor = .clear
        [self._leftArrowButton, self._dayNamesView, self._rightArrowButton].forEach(self.addSubview)
    }
    
    // Private Constants
    private let _buttonHeightRatio: CGFloat = 0.6
    
    // Private Weak Variables
    private weak var _delegate: CalendarHeaderViewDelegate?
    
    // Private Lazy Variables
    private lazy var _leftArrowButton: UIButton = self._createLeftArrowButton()
    private lazy var _rightArrowButton: UIButton = self._createRightArrowButton()
    private lazy var _dayNamesView: UIView = self._createDayNamesView()
    private lazy var _dayNameLabels: [UILabel] = self._createDayNameLabels()
    
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
        leftArrowButton.setColorAdjustment({
            $0.backgroundColor = ColorScheme.background.default
            $0.tintColor = ColorScheme.lines.defaultIcon
        })
        leftArrowButton.setImage(ArrowIcon.Left.asTemplate().scaledByFactor(0.8), for: .normal)
        leftArrowButton.contentMode = .scaleAspectFit
        leftArrowButton.addTarget(
            self,
            action: #selector(self._leftArrowButtonTapped),
            for: .touchUpInside
        )
        return leftArrowButton
    }
    
    func _createRightArrowButton() -> UIButton {
        let rightArrowButton: UIButton = UIButton(type: .system)
        rightArrowButton.setColorAdjustment({
            $0.backgroundColor = ColorScheme.background.default
            $0.tintColor = ColorScheme.lines.defaultIcon
        })
        rightArrowButton.setImage(ArrowIcon.Right.asTemplate().scaledByFactor(0.8), for: .normal)
        rightArrowButton.contentMode = .scaleAspectFit
        rightArrowButton.addTarget(
            self,
            action: #selector(self._rightArrowButtonTapped),
            for: .touchUpInside
        )
        return rightArrowButton
    }
    
    func _createDayNamesView() -> UIView {
        let dayNamesView: UIView = UIView()
        self._dayNameLabels.forEach(dayNamesView.addSubview)
        return dayNamesView
    }
    
    func _createDayNameLabels() -> [UILabel] {
        // Unfortunately, .firstWeekday returns Ints in a range from 1 to 7,
        // which is utterly illogical and not documented at all.
        // This is why we subtract 1 here, so we can use it to subscript the
        // weekdaySymbols array.
        let calendar: Calendar = Calendar.autoupdatingCurrent
        let firstDayOfWeek: Int = calendar.firstWeekday - 1
        let shortWeekdaySymbols: [String] = calendar.shortWeekdaySymbols
        let shiftedShortWeekdaySymbols: ArraySlice<String> =
            shortWeekdaySymbols[firstDayOfWeek..<shortWeekdaySymbols.count] +
            shortWeekdaySymbols[0..<firstDayOfWeek]
        
        return shiftedShortWeekdaySymbols.map({
            let dayNameLabel: UILabel = UILabel()
            dayNameLabel.setColorAdjustment({ ($0 as? UILabel)?.textColor = ColorScheme.text.weekdayName })
            dayNameLabel.font = .xxs
            dayNameLabel.textAlignment = .center
            dayNameLabel.text = $0
            return dayNameLabel
        })
    }
}


// MARK: Computed Variables
private extension CalendarHeaderView {
    var _titleFrame: CGRect {
        let buttonSideLength: CGFloat = self.height * self._buttonHeightRatio
        let width: CGFloat = self.width - (2 * buttonSideLength)
        return CGRect(x: buttonSideLength, y: 0, width: width, height: buttonSideLength)
    }
}


// MARK: Layout Override Implementations
private extension CalendarHeaderView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.width
        let height: CGFloat = self.height
        
        let buttonSideLength: CGFloat = self._buttonHeightRatio * height
        let dayNamesHeight: CGFloat = height - buttonSideLength
        
        let buttonSize: CGSize = CGSize(width: buttonSideLength, height: buttonSideLength)
        let dayNamesViewFrame: CGRect = CGRect(x: 0, y: buttonSideLength, width: width, height: dayNamesHeight)
        
        self._leftArrowButton.size = buttonSize
        
        let rightArrowButton: UIButton = self._rightArrowButton
        rightArrowButton.size = buttonSize
        rightArrowButton.right = width
        
        self._dayNamesView.frame = dayNamesViewFrame
        
        let dayNameLabelWidth: CGFloat = width / 7
        self._dayNameLabels.enumerated().forEach({
            $0.element.frame = CGRect(
                x: $0.offset * dayNameLabelWidth,
                y: 0,
                width: dayNameLabelWidth,
                height: dayNamesHeight
            )
        })
    }
}


// MARK: Button Target Selectors
private extension CalendarHeaderView {
    @objc func _leftArrowButtonTapped() {
        self._delegate?.tappedLeftArrowButton(on: self)
    }
    
    @objc func _rightArrowButtonTapped() {
        self._delegate?.tappedRightArrowButton(on: self)
    }
}


// MARK: Set Design
private extension CalendarHeaderView {
    func _setDesign(_ design: CalendarHeaderViewDesign) {
        self._dayNameLabels.forEach({ label in
            label.font = design.dayNamesFont
            label.setColorAdjustment({
                ($0 as? UILabel)?.textColor = design.dayNamesTextColor()
            })
        })
    }
}
