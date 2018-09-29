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
// MARK: - CalendarDaysVCDelegate
protocol CalendarDaysVCDelegate: class {
    func shouldSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) -> Bool
    func didSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC)
}


// MARK: - CalendarDaysVCDesign
struct CalendarDaysVCDesign {
    var monthNameAndYearFont: UIFont                = CalendarVCDesign.defaultDesign.monthNameAndYearFont
    var dayNumberFont: UIFont                       = CalendarVCDesign.defaultDesign.dayNumberFont
    var todayDayNumberFont: UIFont                  = CalendarVCDesign.defaultDesign.todayDayNumberFont
    
    var monthNameAndYearTextColor: UIColor          = CalendarVCDesign.defaultDesign.monthNameAndYearTextColor
    var normalDayNumberTextColor: UIColor           = CalendarVCDesign.defaultDesign.normalDayNumberTextColor
    var todayDayNumberTextColor: UIColor            = CalendarVCDesign.defaultDesign.todayDayNumberTextColor
    var differentMonthDayNumberTextColor: UIColor   = CalendarVCDesign.defaultDesign.differentMonthDayNumberTextColor
    var pastDayNumberTextColor: UIColor             = CalendarVCDesign.defaultDesign.pastDayNumberTextColor
}


// MARK: - CalendarDaysVC
// MARK: Interface
extension CalendarDaysVC {
    // Readonly
    var month: Date {
        return self._month
    }
    
    // ReadWrite
    var delegate: CalendarDaysVCDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    var topInset: CGFloat {
        get {
            return self._calendarDaysView.topInset
        }
        set(newTopInset) {
            self._calendarDaysView.topInset = newTopInset
        }
    }
    
    var titleLabelFrame: CGRect {
        get {
            return self._calendarDaysView.titleLabelFrame
        }
        set(newTitleLabelFrame) {
            self._calendarDaysView.titleLabelFrame = newTitleLabelFrame
        }
    }
    
    // Functions
    func selectDate(_ date: Date?) {
        self._selectDate(date)
    }
    
    func setDesign(_ design: CalendarDaysVCDesign) {
        self._setDesign(design)
    }
}


// MARK: Class Declaration
class CalendarDaysVC: UIViewController {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        let month: Date = Date().dateAtStartOf(.month)
        self._month = month
        super.init(coder: aDecoder)
        self._calendarDaysView.title = month.toString(.custom("MMMM YYYY"))
    }
    
    // Init
    init(month: Date) {
        self._month = month
        super.init(nibName: nil, bundle: nil)
        self._calendarDaysView.title = month.toString(.custom("MMMM YYYY"))
    }
    
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarDaysVCDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _calendarDaysView: CalendarDaysView = self._createCalendarDaysView()
    
    // Private Variables
    fileprivate var _month: Date
    fileprivate var _design: CalendarDaysVCDesign = CalendarDaysVCDesign()
    
    // Lifecycle Override
    override func loadView() {
        self.view = self._calendarDaysView
    }
}


// MARK: Delegates / DataSources
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
        calendarDaysView.delegate = self
        calendarDaysView.titleFont = design.monthNameAndYearFont
        calendarDaysView.titleColor = design.monthNameAndYearTextColor
        return calendarDaysView
    }
}


// MARK: Delegate / DataSource Implementations
// MARK: CalendarDaysViewDelegate
private extension CalendarDaysVC/*: CalendarDaysViewDelegate*/ {
    func _configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        let date: Date = self.month.dateAtStartOf(.weekOfMonth) + indexPath.row.days
        dateCell.title = date.toString(.custom("d"))
        
        let design: CalendarDaysVCDesign = self._design
        
        let dateIsToday: Bool = date.isToday
        let dateIsInCurrentMonth: Bool = date.isIn(date: self.month, granularity: .month)
        
        var titleColor: UIColor = design.normalDayNumberTextColor
        var titleFont: UIFont = design.dayNumberFont
        
        if dateIsToday {
            titleColor = design.todayDayNumberTextColor
            titleFont = design.todayDayNumberFont
        } else if !dateIsInCurrentMonth {
            titleColor = design.differentMonthDayNumberTextColor
        } else if date.isBefore(date: Date(), granularity: .day) {
            titleColor = design.pastDayNumberTextColor
        }
        
        dateCell.titleColor = titleColor
        dateCell.titleFont = titleFont
    }
    
    func _shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool {
        guard let delegate: CalendarDaysVCDelegate = self.delegate else { return true }
        let date: Date = self.month.dateAtStartOf(.weekOfMonth) + indexPath.row.days
        return delegate.shouldSelect(date, on: self)
    }
    
    func _didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        guard let delegate: CalendarDaysVCDelegate = self.delegate else { return }
        let date: Date = self.month.dateAtStartOf(.weekOfMonth) + indexPath.row.days
        delegate.didSelect(date, on: self)
    }
}


// MARK: Select Date
private extension CalendarDaysVC {
    func _selectDate(_ date: Date?) {
        var indexPath: IndexPath? = nil
        hasDate: if let date: Date = date {
            let firstDisplayedDay: Date = self.month.dateAtStartOf(.weekOfMonth)
            let lastDisplayedDay: Date = firstDisplayedDay + 41.days
            guard date.isBetween(date: firstDisplayedDay, and: lastDisplayedDay) else { break hasDate }
            guard let row: Int = (date - self.month.dateAtStartOf(.weekOfMonth)).day else { break hasDate }
            indexPath = IndexPath(row: row, section: 0)
        }
        self._calendarDaysView.selectDateCell(at: indexPath)
    }
}


// MARK: Set Design
private extension CalendarDaysVC {
    func _setDesign(_ design: CalendarDaysVCDesign) {
        self._design = design
        
        let calendarDaysView: CalendarDaysView = self._calendarDaysView
        calendarDaysView.reloadCells()
        calendarDaysView.titleFont = design.monthNameAndYearFont
        calendarDaysView.titleColor = design.monthNameAndYearTextColor
    }
}
