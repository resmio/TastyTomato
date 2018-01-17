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


// MARK: - CalendarHeaderViewDesign
struct CalendarHeaderViewDesign {
    var dayNamesFont: UIFont        = CalendarVCDesign.defaultDesign.dayNamesFont
    var dayNamesTextColor: UIColor  = CalendarVCDesign.defaultDesign.dayNamesTextColor
}


// MARK: - CalendarHeaderView
// MARK: Interface
extension CalendarHeaderView {
    // Readonly
    var titleFrame: CGRect {
        return self._titleFrame
    }
    
    // ReadWrite
    var delegate: CalendarHeaderViewDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    // Functions
    func setDesign(_ design: CalendarHeaderViewDesign) {
        self._setDesign(design)
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
    
    // Private Constants
    fileprivate let _buttonHeightRatio: CGFloat = 0.6
    fileprivate let _gradientWidthRatio: CGFloat = 0.05
    
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarHeaderViewDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _gradientLayer: CAGradientLayer = self._createGradientLayer()
    fileprivate lazy var _leftArrowButton: UIButton = self._createLeftArrowButton()
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
    func _createGradientLayer() -> CAGradientLayer {
        let whiteClear: CGColor = UIColor.white.withAlpha(0).cgColor
        let white: CGColor = UIColor.white.cgColor
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [white, white, whiteClear, whiteClear, white, white]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }
    
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
            dayNameLabel.font = .xxxs
            dayNameLabel.textColor = .gray555555
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
        let gradientWidth: CGFloat = buttonSideLength * (1 + self._gradientWidthRatio)
        let width: CGFloat = self.width - (2 * gradientWidth)
        return CGRect(x: gradientWidth, y: 0, width: width, height: buttonSideLength)
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
        
        let buttonSideLengthRatio: CGFloat = buttonSideLength / width
        let gradientRatio: CGFloat = self._gradientWidthRatio
        let buttonSideLengthPlusGradientRatio: CGFloat = buttonSideLengthRatio + gradientRatio
        
        let gradientLayer: CAGradientLayer = self._gradientLayer
        gradientLayer.frame.size = CGSize(width: width, height: buttonSize.height)
        gradientLayer.locations = [
            0,
            buttonSideLengthRatio,
            buttonSideLengthPlusGradientRatio,
            1 - buttonSideLengthPlusGradientRatio,
            1 - buttonSideLengthRatio,
            1
        ] as [NSNumber]
        
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


// MARK: Add Subviews
private extension CalendarHeaderView {
    func _addSubviews() {
        self.layer.addSublayer(self._gradientLayer)
        self.addSubview(self._leftArrowButton)
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


// MARK: Set Design
private extension CalendarHeaderView {
    func _setDesign(_ design: CalendarHeaderViewDesign) {
        self._dayNameLabels.forEach({
            $0.font = design.dayNamesFont
            $0.textColor = design.dayNamesTextColor
        })
    }
}
