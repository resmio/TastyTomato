//
//  CalendarDaysVC.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 08.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit
import SwiftDate


// MARK: // Internal
// MARK: -
protocol CalendarDaysVCDelegate: class {
    func shouldSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) -> Bool
    func didSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC)
}


// MARK: -
struct CalendarDaysVCDesign {
    var monthNameAndYearFont: UIFont                = CalendarVCDesign.defaultDesign.monthNameAndYearFont
    var dayNumberFont: UIFont                       = CalendarVCDesign.defaultDesign.dayNumberFont
    var todayDayNumberFont: UIFont                  = CalendarVCDesign.defaultDesign.todayDayNumberFont
    
    var monthNameAndYearTextColor: () -> UIColor          = CalendarVCDesign.defaultDesign.monthNameAndYearTextColor
    var normalDayNumberTextColor: () -> UIColor           = CalendarVCDesign.defaultDesign.normalDayNumberTextColor
    var todayDayNumberTextColor: () -> UIColor            = CalendarVCDesign.defaultDesign.todayDayNumberTextColor
    var differentMonthDayNumberTextColor: () -> UIColor   = CalendarVCDesign.defaultDesign.differentMonthDayNumberTextColor
    var pastDayNumberTextColor: () -> UIColor             = CalendarVCDesign.defaultDesign.pastDayNumberTextColor
}


// MARK: - CalendarDaysVC
// MARK: Interface
extension CalendarDaysVC {
    // Readonly
    var month: Date {
        return self._month
    }
    
    // ReadWrite
    var topInset: CGFloat {
        get { return self._calendarDaysView.topInset }
        set { self._calendarDaysView.topInset = newValue }
    }
    
    var titleLabelFrame: CGRect {
        get { return self._calendarDaysView.titleLabelFrame }
        set { self._calendarDaysView.titleLabelFrame = newValue }
    }
    
    // Setters
    func setDelegate(_ delegate: CalendarDaysVCDelegate?) {
        self._delegate = delegate
    }
    
    func setDesign(_ design: CalendarDaysVCDesign) {
        self._setDesign(design)
    }
    
    // Functions
    func selectDate(_ date: Date?) {
        self._selectDate(date)
    }
}


// MARK: Class Declaration
class CalendarDaysVC: UIViewController {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    // Init
    init(month: Date) {
        super.init(nibName: nil, bundle: nil)
        self._month = month
        self._init()
    }
    
    // Common Init
    private func _init() {
        self._calendarDaysView.title = self.month.toString(.custom("MMMM YYYY"))
    }
    
    // Private Weak Variables
    private weak var _delegate: CalendarDaysVCDelegate?
    
    // Private Lazy Variables
    private lazy var _calendarDaysView: CalendarDaysView = self._createCalendarDaysView()
    
    // Private Variables
    private var _month: Date = Date().dateAtStartOf(.month)
    private var _design: CalendarDaysVCDesign = CalendarDaysVCDesign()
    
    // Lifecycle Override
    override func loadView() {
        self.view = self._calendarDaysView
    }
}


// MARK: Protocol Conformances
// MARK: CalendarDaysViewDelegate
extension CalendarDaysVC: CalendarDaysViewDelegate {
    func configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        self._configure(dateCell, for: indexPath, on: calendarDaysView)
    }
    
    func shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool {
        return self._shouldSelect(dateCell, at: indexPath, on: calendarDaysView)
    }
    
    func didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        self._didSelect(dateCell, at: indexPath, on: calendarDaysView)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarDaysVC {
    func _createCalendarDaysView() -> CalendarDaysView {
        let design: CalendarDaysVCDesign = self._design
        
        let calendarDaysView: CalendarDaysView = CalendarDaysView()
        calendarDaysView.setColorAdjustment({
            ($0 as? CalendarDaysView)?.titleColor = design.monthNameAndYearTextColor()
        })
        calendarDaysView.setDelegate(self)
        calendarDaysView.titleFont = design.monthNameAndYearFont
        return calendarDaysView
    }
}


// MARK: Protocol Conformance Implementations
// MARK: CalendarDaysViewDelegate
private extension CalendarDaysVC/*: CalendarDaysViewDelegate*/ {
    func _configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        let date: Date = self.month.dateAtStartOf(.weekOfMonth) + indexPath.row.days
        dateCell.setTitle(date.toString(.custom("d")))
        
        let design: CalendarDaysVCDesign = self._design
        
        let dateIsToday: Bool = date.isToday
        let dateIsInCurrentMonth: Bool = date.isInside(date: self.month, granularity: .month)
        
        var titleColor: () -> UIColor = design.normalDayNumberTextColor
        var titleFont: UIFont = design.dayNumberFont
        
        if dateIsToday {
            titleColor = design.todayDayNumberTextColor
            titleFont = design.todayDayNumberFont
        } else if date.isBeforeDate(Date(), granularity: .day) {
            titleColor = design.pastDayNumberTextColor
        } else if !dateIsInCurrentMonth {
            titleColor = design.differentMonthDayNumberTextColor
        }
        
        dateCell.setTitleColor(titleColor, for: .normal)
        dateCell.setTitleFont(titleFont)
    }
    
    func _shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool {
        guard let delegate: CalendarDaysVCDelegate = self._delegate else { return true }
        let date: Date = self.month.dateAtStartOf(.weekOfMonth) + indexPath.row.days
        return delegate.shouldSelect(date, on: self)
    }
    
    func _didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        guard let delegate: CalendarDaysVCDelegate = self._delegate else { return }
        let date: Date = self.month.dateAtStartOf(.weekOfMonth) + indexPath.row.days
        delegate.didSelect(date, on: self)
    }
}


// MARK: Select Date
private extension CalendarDaysVC {
    func _selectDate(_ date: Date?) {
        self._calendarDaysView.selectDateCell(at: {
            guard let date: Date = date else { return nil }
            let firstDisplayedDay: Date = self.month.dateAtStartOf(.weekOfMonth)
            let lastDisplayedDay: Date = firstDisplayedDay + 41.days
            guard date.isInRange(date: firstDisplayedDay, and: lastDisplayedDay) else { return nil }
            let row: Int = Int(firstDisplayedDay.getInterval(toDate: date, component: .day))
            return IndexPath(row: row, section: 0)
        }())
    }
}


// MARK: Set Design
private extension CalendarDaysVC {
    func _setDesign(_ design: CalendarDaysVCDesign) {
        self._design = design
        
        let calendarDaysView: CalendarDaysView = self._calendarDaysView
        calendarDaysView.setColorAdjustment({
            ($0 as? CalendarDaysView)?.titleColor = design.monthNameAndYearTextColor()
        })
        calendarDaysView.reloadCells()
        calendarDaysView.titleFont = design.monthNameAndYearFont
    }
}
