//
//  CalendarVC.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 30.11.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit
import SignificantSpices
import SwiftDate


// MARK: // Public
// MARK: - CalendarVCDelegate
public protocol CalendarVCDelegate: class {
    func didSelectDate(_ date: Date, on calendarVC: CalendarVC)
}


// MARK: - CalendarVC
// MARK: Interface
public extension CalendarVC {
    // Readonly
    /**
     */
    var displayedMonthAndYear: Date {
        return self._displayedMonthAndYear
    }
    
    // ReadWrite
    var delegate: CalendarVCDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    /**
     */
    var selectedDate: Date? {
        get {
            return self._selectedDate
        }
        set(newSelectedDate) {
            self._selectedDate = newSelectedDate
        }
    }
    
    // Functions
    func setDisplayedMonthAndYear(from date: Date, animated: Bool = true) {
        self._setDisplayedMonthAndYear(from: date, animated: animated)
    }
}


// MARK: Class Declaration
public class CalendarVC: UIViewController {
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarVCDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _calendarVCView: CalendarVCView = self._createCalendarVCView()
    fileprivate lazy var _pageVC: UIPageViewController = self._createPageVC()
    
    // Private Variables
    fileprivate var _currentDaysVC: _CalendarDaysVC?
    fileprivate var _isPaging: Bool = false
    fileprivate var _displayedMonthAndYear: Date = Date()
    fileprivate var _firstDisplayedDay: Date = Date()
    fileprivate var __selectedDate: Date?
    
    // Lifecycle Overrides
    public override func loadView() {
        self.view = self._calendarVCView
    }
    
    public override func viewDidLoad() {
        self._viewDidLoad()
    }
}


// MARK: Delegates / DataSources
// MARK: CalendarHeaderViewDelegate
extension CalendarVC: CalendarHeaderViewDelegate {
    func tappedLeftArrowButton(on calendarHeaderView: CalendarHeaderView) {
        self._showPreviousMonth()
    }
    
    func tappedRightArrowButton(on calendarHeaderView: CalendarHeaderView) {
        self._showNextMonth()
    }
}


// MARK: UIPageViewControllerDelegate
extension CalendarVC: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self._pageViewController(pageViewController, willTransitionTo: pendingViewControllers)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self._isPaging = false
    }
}


// MARK: UIPageViewControllerDataSource
extension CalendarVC: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self._daysVC(for: (viewController as! _CalendarDaysVC).month - 1.month)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self._daysVC(for: (viewController as! _CalendarDaysVC).month + 1.month)
    }
}


// MARK: CalendarDaysViewDelegate
extension CalendarVC: CalendarDaysViewDelegate {
    func configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        self._configure(dateCell, for: indexPath, on: calendarDaysView)
    }
    
    func shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool {
        return true
    }
    
    func didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarVC {
    func _createCalendarVCView() -> CalendarVCView {
        let calendarVCView: CalendarVCView = CalendarVCView()
        calendarVCView.backgroundColor = .white
        calendarVCView.headerView.delegate = self
        return calendarVCView
    }
    
    func _createPageVC() -> UIPageViewController {
        let pageVC: UIPageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        let initialVC: _CalendarDaysVC = _CalendarDaysVC(month: self._displayedMonthAndYear)
        initialVC.calendarDaysView.delegate = self
        pageVC.setViewControllers(
            [initialVC],
            direction: .forward,
            animated: false,
            completion: nil
        )
        self._currentDaysVC = initialVC
        
        pageVC.delegate = self
        pageVC.dataSource = self
        return pageVC
    }
}


// MARK: Computed Variables
private extension CalendarVC {
    var _selectedDate: Date? {
        get {
            return self.__selectedDate
        }
        set(newSelectedDate) {
            let roundedNewSelectedDate: Date? = newSelectedDate?.startOf(component: .day)
            guard roundedNewSelectedDate != self.__selectedDate else { return }
            
            let firstDisplayedDay: Date = self._displayedMonthAndYear.startOf(component: .weekOfYear)
            let lastDisplayedDay: Date = firstDisplayedDay + 41.days
            
            if let newDate: Date = roundedNewSelectedDate {
                
            }
            
            
            self.__selectedDate = roundedNewSelectedDate
        }
    }
}


// MARK: Lifecycle Override Implementations
private extension CalendarVC {
    func _viewDidLoad() {
        super.viewDidLoad()
        
        let pageVC: UIPageViewController = self._pageVC
        self.embed(pageVC, into: self._calendarVCView.pageVCViewContainer)
        pageVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}


// MARK: Delegates / DataSources
// MARK: UIPageViewControllerDelegate
private extension CalendarVC/*: UIPageViewControllerDelegate*/ {
    func _pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self._isPaging = true
        self._currentDaysVC = (pendingViewControllers[0] as! _CalendarDaysVC)
    }
}


// MARK: CalendarDaysViewDelegate
private extension CalendarVC/*: CalendarDaysViewDelegate*/ {
    func _configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        let date: Date = self._firstDisplayedDay + indexPath.row.days
        dateCell.title = "\(date.day)"
    }
}


// MARK: PageViewController Helpers
private extension CalendarVC {
    func _showPreviousMonth() {
        guard let currentVC: _CalendarDaysVC = self._currentDaysVC else { return }
        let vc: _CalendarDaysVC = self._daysVC(for: currentVC.month - 1.month)
        self._switchTo(daysVC: vc, direction: .reverse)
    }
    
    func _showNextMonth() {
        guard let currentVC: _CalendarDaysVC = self._currentDaysVC else { return }
        let vc: _CalendarDaysVC = self._daysVC(for: currentVC.month + 1.month)
        self._switchTo(daysVC: vc, direction: .forward)
    }
    
    func _switchTo(daysVC: _CalendarDaysVC, direction: UIPageViewControllerNavigationDirection, animated: Bool = true) {
        guard !self._isPaging else { return }
        self._isPaging = true
        self._pageVC.setViewControllers(
            [daysVC],
            direction: direction,
            animated: animated,
            completion: { _ in
                self._isPaging = false
            }
        )
    }
    
    func _daysVC(for month: Date) -> _CalendarDaysVC {
        let daysVC: _CalendarDaysVC = _CalendarDaysVC(month: month)
        daysVC.calendarDaysView.delegate = self
        return daysVC
    }
}


// MARK: Set Displayed Month
private extension CalendarVC {
    func _setDisplayedMonthAndYear(from date: Date, animated: Bool = true) {
        guard !date.isIn(date: self._displayedMonthAndYear, granularity: .month) else { return }
        let roundedDate: Date = date.startOf(component: .month)
        let vc: _CalendarDaysVC = self._daysVC(for: roundedDate)
        
        let isLaterMonth: Bool = date.isAfter(date: date, granularity: .month)
        let direction: UIPageViewControllerNavigationDirection = isLaterMonth ? .forward : .reverse
        
        self._displayedMonthAndYear = roundedDate
        self._firstDisplayedDay = roundedDate.startOf(component: .weekOfYear)
        self._switchTo(daysVC: vc, direction: direction, animated: animated)
    }
}


// MARK: - _CalendarDaysVC
private class _CalendarDaysVC: UIViewController {
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        self.month = Date()
        super.init(coder: aDecoder)
    }
    
    // Init
    init(month: Date) {
        self.month = month
        super.init(nibName: nil, bundle: nil)
    }
    
    // Constants
    let calendarDaysView: CalendarDaysView = CalendarDaysView()
    
    // Variables
    private(set) var month: Date
    
    // Lifecycle Override
    override func loadView() {
        self.view = self.calendarDaysView
    }
}
