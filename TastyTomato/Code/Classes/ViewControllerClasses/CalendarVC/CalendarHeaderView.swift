//
//  CalendarHeaderView.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 04.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: - CalendarHeaderViewDelegate
protocol CalendarHeaderViewDelegate: class {
    func tappedLeftArrowButton(on calendarHeaderView: CalendarHeaderView)
    func tappedRightArrowButton(on calendarHeaderView: CalendarHeaderView)
}


// MARK: - CalendarHeaderView
// MARK: Interface
extension CalendarHeaderView {
    var delegate: CalendarHeaderViewDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    var title: String {
        get {
            return self._monthNameYearLabel.text ?? ""
        }
        set(newTitle) {
            self._monthNameYearLabel.text = newTitle
        }
    }
}

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
    
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarHeaderViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _leftArrowButton: UIButton = self._createLeftArrowButton()
    fileprivate lazy var _monthNameYearLabel: UILabel = self._createMonthNameYearLabel()
    fileprivate lazy var _rightArrowButton: UIButton = self._createRightArrowButton()
    fileprivate lazy var _dayNamesView: UIView = self._createDayNamesView()
    fileprivate lazy var _dayNameLabels: [UILabel] = self._createDayNameLabels()
    
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
        leftArrowButton.tintColor = .black
        leftArrowButton.setImage(ArrowIcon.Left.asTemplate().scaledByFactor(0.8), for: .normal)
        leftArrowButton.contentMode = .scaleAspectFit
        leftArrowButton.addTarget(
            self,
            action: #selector(_leftArrowButtonTapped),
            for: .touchUpInside
        )
        return leftArrowButton
    }
    
    func _createMonthNameYearLabel() -> UILabel {
        let monthNameYearLabel: UILabel = UILabel()
        monthNameYearLabel.text = "Monthname Year"
        monthNameYearLabel.textAlignment = .center
        monthNameYearLabel.adjustsFontSizeToFitWidth = true
        return monthNameYearLabel
    }
    
    func _createRightArrowButton() -> UIButton {
        let rightArrowButton: UIButton = UIButton(type: .system)
        rightArrowButton.tintColor = .black
        rightArrowButton.setImage(ArrowIcon.Right.asTemplate().scaledByFactor(0.8), for: .normal)
        rightArrowButton.contentMode = .scaleAspectFit
        rightArrowButton.addTarget(
            self,
            action: #selector(_rightArrowButtonTapped),
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
            dayNameLabel.font = .systemFont(ofSize: 12)
            dayNameLabel.textColor = .gray555555
            dayNameLabel.textAlignment = .center
            dayNameLabel.text = $0
            return dayNameLabel
        })
    }
}


// MARK: Layout Override Implementations
private extension CalendarHeaderView {
    func _layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.width
        let height: CGFloat = self.height
        
        let monthNameYearLabelHeight: CGFloat = 0.6 * height
        let dayNamesHeight: CGFloat = height - monthNameYearLabelHeight
        
        let monthNameYearLabelSize: CGSize = CGSize(width: width - height, height: monthNameYearLabelHeight)
        let buttonSize: CGSize = CGSize(width: monthNameYearLabelHeight, height: monthNameYearLabelHeight)
        let dayNamesViewFrame: CGRect = CGRect(x: 0, y: monthNameYearLabelHeight, width: width, height: dayNamesHeight)
        
        self._leftArrowButton.size = buttonSize
        
        let monthNameYearLabel: UILabel = self._monthNameYearLabel
        monthNameYearLabel.size = monthNameYearLabelSize
        monthNameYearLabel.centerHInSuperview()
        
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


// MARK: Add Subviews
private extension CalendarHeaderView {
    func _addSubviews() {
        self.addSubview(self._leftArrowButton)
        self.addSubview(self._monthNameYearLabel)
        self.addSubview(self._rightArrowButton)
        self.addSubview(self._dayNamesView)
    }
}


// MARK: Button Target Selectors
@objc private extension CalendarHeaderView {
    func _leftArrowButtonTapped() {
        self.delegate?.tappedLeftArrowButton(on: self)
    }
    
    func _rightArrowButtonTapped() {
        self.delegate?.tappedRightArrowButton(on: self)
    }
}
