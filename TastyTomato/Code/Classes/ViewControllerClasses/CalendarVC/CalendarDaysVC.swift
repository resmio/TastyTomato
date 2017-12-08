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
    func selectedDate(for calendarDaysVC: CalendarDaysVC) -> Date?
    func shouldSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) -> Bool
    func didSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC)
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
}


// MARK: Class Declaration
class CalendarDaysVC: UIViewController {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        let month: Date = Date().startOf(component: .month)
        self._month = month
        super.init(coder: aDecoder)
        self._calendarDaysView.title = month.string(custom: "MMMM YYYY")
    }
    
    // Init
    init(month: Date) {
        self._month = month
        super.init(nibName: nil, bundle: nil)
        self._calendarDaysView.title = month.string(custom: "MMMM YYYY")
    }
    
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarDaysVCDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _calendarDaysView: CalendarDaysView = self._createCalendarDaysView()
    
    // Private Variables
    fileprivate var _month: Date
    
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
        let calendarDaysView: CalendarDaysView = CalendarDaysView()
        calendarDaysView.delegate = self
        return calendarDaysView
    }
}


// MARK: Delegate / DataSource Implementations
// MARK: CalendarDaysViewDelegate
private extension CalendarDaysVC/*: CalendarDaysViewDelegate*/ {
    func _configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        let date: Date = self.month.startWeek + indexPath.row.days
        dateCell.title = date.string(custom: "d")
        
        if let selectedDate: Date = self.delegate?.selectedDate(for: self) {
            dateCell.isSelected = (date == selectedDate)
        } else {
            dateCell.isSelected = false
        }
        
        let dateIsToday: Bool = date.isToday
        let dateIsInCurrentMonth: Bool = date.isIn(date: self.month, granularity: .month)
        dateCell.displayTitleInBold(dateIsToday)
        
        if dateIsToday {
            dateCell.titleColor = .blue018EA6
        } else if date.isBefore(date: Date(), granularity: .day) {
            if dateIsInCurrentMonth {
                dateCell.titleColor = .gray999999
            } else {
                dateCell.titleColor = .grayCCCCCC
            }
        } else if dateIsInCurrentMonth {
            dateCell.titleColor = .black
        } else {
            dateCell.titleColor = .grayCCCCCC
        }
    }
    
    func _shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool {
        guard let delegate: CalendarDaysVCDelegate = self.delegate else { return true }
        let date: Date = self.month.startWeek + indexPath.row.days
        return delegate.shouldSelect(date, on: self)
    }
    
    func _didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        guard let delegate: CalendarDaysVCDelegate = self.delegate else { return }
        let date: Date = self.month.startWeek + indexPath.row.days
        delegate.didSelect(date, on: self)
    }
}
