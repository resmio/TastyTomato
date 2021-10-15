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
public protocol CalendarVCDelegate: AnyObject {
    func shouldSelectDate(_ date: Date, on calendarVC: CalendarVC) -> Bool
    func didSelectDate(_ date: Date, on calendarVC: CalendarVC)
}


// MARK: - CalendarVCDesign
public struct CalendarVCDesign {
    public init() {}
    
    public static let defaultDesign: CalendarVCDesign = CalendarVCDesign()
    
    public var monthNameAndYearFont: UIFont = .m
    public var dayNamesFont: UIFont = .xxs
    public var dayNumberFont: UIFont = .m
    public var todayDayNumberFont: UIFont = .m
    
    public var monthNameAndYearTextColor: () -> UIColor = { ColorScheme.text.monthHeading }
    public var dayNamesTextColor: () -> UIColor = { ColorScheme.text.weekdayName }
    public var normalDayNumberTextColor: () -> UIColor = { ColorScheme.text.dateInCurrentMonth }
    public var todayDayNumberTextColor: () -> UIColor = { ColorScheme.text.today }
    public var differentMonthDayNumberTextColor: () -> UIColor = { ColorScheme.text.dateInOtherMonth }
    public var pastDayNumberTextColor: () -> UIColor = { ColorScheme.text.dateInPast }
}


// MARK: - CalendarVC
// MARK: Interface
public extension CalendarVC {
    // Readonly
    var displayedMonthAndYear: Date {
        return self._displayedMonthAndYear
    }
    
    // ReadWrite
    var selectedDate: Date? {
        get {
            return self._selectedDate
        }
        set(newSelectedDate) {
            self._selectedDate = newSelectedDate
        }
    }
    
    // Setters
    func setDelegate(_ delegate: CalendarVCDelegate?) {
        self._delegate = delegate
    }
    
    func setDisplayedMonthAndYear(from date: Date, animated: Bool = true) {
        self._setDisplayedMonthAndYear(from: date, animated: animated)
    }
    
    func setDesign(_ design: CalendarVCDesign) {
        self._setDesign(design)
    }
}


// MARK: Class Declaration
public class CalendarVC: UIViewController {
    // Private Weak Variables
    private weak var _delegate: CalendarVCDelegate?
    
    // Private Lazy Variables
    private lazy var _calendarVCView: CalendarVCView = self._createCalendarVCView()
    private lazy var _pageVC: UIPageViewController = self._createPageVC()
    
    // Private Variables
    private var _isPaging: Bool = false
    private var __selectedDate: Date?
    private var _design: CalendarVCDesign = CalendarVCDesign()
    
    // View Lifecycle Overrides
    public override func loadView() {
        self.view = self._calendarVCView
    }
    
    public override func viewDidLoad() {
        self._viewDidLoad()
    }
    
    public override func viewDidLayoutSubviews() {
        self._viewDidLayoutSubviews()
    }
}


// MARK: Protocol Conformances
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
        self._isPaging = true
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self._isPaging = false
    }
}


// MARK: UIPageViewControllerDataSource
extension CalendarVC: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self._daysVC(for: (viewController as! CalendarDaysVC).month - 1.months)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self._daysVC(for: (viewController as! CalendarDaysVC).month + 1.months)
    }
}


// MARK: CalendarDaysVCDelegate
extension CalendarVC: CalendarDaysVCDelegate {
    func selectedDate(for calendarDaysVC: CalendarDaysVC) -> Date? {
        return self._selectedDate
    }
    
    func shouldSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) -> Bool {
        return self._delegate?.shouldSelectDate(date, on: self) ?? true
    }
    
    func didSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) {
        self._didSelect(date, on: calendarDaysVC)
    }
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarVC {
    func _createCalendarVCView() -> CalendarVCView {
        let calendarVCView: CalendarVCView = CalendarVCView()
        calendarVCView.headerView.setDelegate(self)
        return calendarVCView
    }
    
    func _createPageVC() -> UIPageViewController {
        let pageVC: UIPageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: [.interPageSpacing: 20]
        )
        
        let initialVC: CalendarDaysVC = self._daysVC(for: Date().dateAtStartOf(.month))
        pageVC.setViewControllers(
            [initialVC],
            direction: .forward,
            animated: false,
            completion: nil
        )

        pageVC.delegate = self
        pageVC.dataSource = self
        return pageVC
    }
}


// MARK: Computed Variables
private extension CalendarVC {
    // Readonly
    var _currentDaysVC: CalendarDaysVC {
        return self._pageVC.viewControllers![0] as! CalendarDaysVC
    }
    
    var _displayedMonthAndYear: Date {
        return self._currentDaysVC.month
    }
    
    var _firstDisplayedDay: Date {
        return self._displayedMonthAndYear.dateAtStartOf(.weekOfMonth)
    }
    
    // ReadWrite
    var _selectedDate: Date? {
        get {
            return self.__selectedDate
        }
        set(newSelectedDate) {
            let roundedNewSelectedDate: Date? = newSelectedDate?.dateAtStartOf(.day)
            guard roundedNewSelectedDate != self.__selectedDate else { return }
            
            let currentDaysVC: CalendarDaysVC = self._currentDaysVC
            let firstDisplayedDay: Date = currentDaysVC.month.dateAtStartOf(.weekOfMonth)
            let lastDisplayedDay: Date = firstDisplayedDay + 41.days
            if roundedNewSelectedDate?.isInRange(date: firstDisplayedDay, and: lastDisplayedDay) ?? true {
                currentDaysVC.selectDate(roundedNewSelectedDate)
            }
            
            self.__selectedDate = roundedNewSelectedDate
        }
    }
}


// MARK: View Lifecycle Override Implementations
private extension CalendarVC {
    func _viewDidLoad() {
        super.viewDidLoad()
        self.embed(self._pageVC, into: self._calendarVCView.pageVCContainerView)
    }
    
    func _viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self._adjustDaysVCLayout()
    }
}


// MARK: Protocol Conformance Implementations
// MARK: CalendarDaysVCDelegate
private extension CalendarVC/*: CalendarDaysVCDelegate*/ {
    func _didSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) {
        self.__selectedDate = date
        self._delegate?.didSelectDate(date, on: self)
    }
}


// MARK: PageViewController Helpers
private extension CalendarVC {
    func _showPreviousMonth() {
        let vc: CalendarDaysVC = self._daysVC(for: self._currentDaysVC.month - 1.months)
        self._switchTo(daysVC: vc, direction: .reverse, animated: false)
    }
    
    func _showNextMonth() {
        let vc: CalendarDaysVC = self._daysVC(for: self._currentDaysVC.month + 1.months)
        self._switchTo(daysVC: vc, direction: .forward, animated: false)
    }
    
    func _switchTo(daysVC: CalendarDaysVC, direction: UIPageViewController.NavigationDirection, animated: Bool = true) {
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
    
    func _daysVC(for month: Date) -> CalendarDaysVC {
        let daysVC: CalendarDaysVC = CalendarDaysVC(month: month)
        daysVC.setDelegate(self)
        daysVC.selectDate(self.selectedDate)
        self._adjustDaysVCLayout(daysVC)
        self._applyDesign(design: self._design, to: daysVC)
        return daysVC
    }
    
    func _adjustDaysVCLayout(_ daysVC: CalendarDaysVC? = nil) {
        let daysVC: CalendarDaysVC = daysVC ?? self._currentDaysVC
        let headerView: CalendarHeaderView = self._calendarVCView.headerView
        daysVC.topInset = headerView.height
        daysVC.titleLabelFrame = headerView.titleFrame
    }
}


// MARK: Set Displayed Month
private extension CalendarVC {
    func _setDisplayedMonthAndYear(from date: Date, animated: Bool) {
        let currentMonthAndYear: Date = self._displayedMonthAndYear
        guard !date.isInside(date: currentMonthAndYear, granularity: .month) else { return }
        let startOfNewMonth: Date = date.dateAtStartOf(.month)
        let vc: CalendarDaysVC = self._daysVC(for: startOfNewMonth)
        
        let isLaterMonth: Bool = startOfNewMonth.isAfterDate(currentMonthAndYear, granularity: .month)
        let direction: UIPageViewController.NavigationDirection = isLaterMonth ? .forward : .reverse
        
        self._switchTo(daysVC: vc, direction: direction, animated: animated)
        
        // If the new month is not adjacent to the old one,
        // we need to flush the vc-cash of the pageVC,
        // so the correct month will be shown on the next
        // button tap or swipe.  Unfortunately, it seems
        // as though there's no better way to do this...
        let startOfPreviousMonth: Date = currentMonthAndYear - 1.months
        let startOfNextMonth: Date = currentMonthAndYear + 1.months
        if startOfNewMonth >< [startOfPreviousMonth, startOfNextMonth] {
            let pageVC: UIPageViewController = self._pageVC
            pageVC.dataSource = nil
            pageVC.dataSource = self
        }
    }
}


// MARK: Set Design
private extension CalendarVC {
    func _setDesign(_ design: CalendarVCDesign) {
        self._design = design
        self._applyDesign(design: design, to: self._currentDaysVC)
        self._calendarVCView.headerView.setDesign(CalendarHeaderViewDesign(
            dayNamesFont: design.dayNamesFont,
            dayNamesTextColor: design.dayNamesTextColor
        ))
    }
    
    // Helper
    func _applyDesign(design: CalendarVCDesign, to daysVC: CalendarDaysVC) {
        daysVC.setDesign(CalendarDaysVCDesign(
            monthNameAndYearFont: design.monthNameAndYearFont,
            dayNumberFont: design.dayNumberFont,
            todayDayNumberFont: design.todayDayNumberFont,
            monthNameAndYearTextColor: design.monthNameAndYearTextColor,
            normalDayNumberTextColor: design.normalDayNumberTextColor,
            todayDayNumberTextColor: design.todayDayNumberTextColor,
            differentMonthDayNumberTextColor: design.differentMonthDayNumberTextColor,
            pastDayNumberTextColor: design.pastDayNumberTextColor
        ))
    }
}
