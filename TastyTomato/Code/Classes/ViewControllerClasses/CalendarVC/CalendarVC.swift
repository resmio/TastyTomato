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


// MARK: - CalendarVCDesign
public struct CalendarVCDesign {
    public init() {}
    
    public static let defaultDesign: CalendarVCDesign = CalendarVCDesign()
    
    public var monthNameAndYearFont: UIFont = .m
    public var dayNamesFont: UIFont = .xxs
    public var dayNumberFont: UIFont = .m
    public var todayDayNumberFont: UIFont = .m
    
    public var monthNameAndYearTextColor: UIColor = .black
    public var dayNamesTextColor: UIColor = .gray555555
    public var normalDayNumberTextColor: UIColor = .black
    public var todayDayNumberTextColor: UIColor = .blue018EA6
    public var differentMonthDayNumberTextColor: UIColor = .grayCCCCCC
    public var pastDayNumberTextColor: UIColor = .gray999999
}


// MARK: - CalendarVC
// MARK: Interface
public extension CalendarVC {
    // Readonly
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
    
    func setDesign(_ design: CalendarVCDesign) {
        self._setDesign(design)
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
    fileprivate var _isPaging: Bool = false
    fileprivate var __selectedDate: Date?
    fileprivate var _design: CalendarVCDesign = CalendarVCDesign()
    
    // Lifecycle Overrides
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
        self._isPaging = true
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self._isPaging = false
    }
}


// MARK: UIPageViewControllerDataSource
extension CalendarVC: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self._daysVC(for: (viewController as! CalendarDaysVC).month - 1.month)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self._daysVC(for: (viewController as! CalendarDaysVC).month + 1.month)
    }
}


// MARK: CalendarDaysVCDelegate
extension CalendarVC: CalendarDaysVCDelegate {
    func selectedDate(for calendarDaysVC: CalendarDaysVC) -> Date? {
        return self._selectedDate
    }
    
    func shouldSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) -> Bool {
        return true
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
        calendarVCView.backgroundColor = .white
        calendarVCView.headerView.delegate = self
        return calendarVCView
    }
    
    func _createPageVC() -> UIPageViewController {
        let pageVC: UIPageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: [
                UIPageViewControllerOptionInterPageSpacingKey: 20
            ]
        )
        
        let initialVC: CalendarDaysVC = self._daysVC(for: Date().startOf(component: .month))
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
        return self._displayedMonthAndYear.startWeek
    }
    
    // ReadWrite
    var _selectedDate: Date? {
        get {
            return self.__selectedDate
        }
        set(newSelectedDate) {
            let roundedNewSelectedDate: Date? = newSelectedDate?.startOfDay
            guard roundedNewSelectedDate != self.__selectedDate else { return }
            
            let currentDaysVC: CalendarDaysVC = self._currentDaysVC
            let firstDisplayedDay: Date = currentDaysVC.month.startWeek
            let lastDisplayedDay: Date = firstDisplayedDay + 41.days
            if roundedNewSelectedDate?.isBetween(date: firstDisplayedDay, and: lastDisplayedDay) ?? true {
                currentDaysVC.selectDate(roundedNewSelectedDate)
            }
            
            self.__selectedDate = roundedNewSelectedDate
        }
    }
}


// MARK: Lifecycle Override Implementations
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


// MARK: Delegate / DataSource Implementations
// MARK: CalendarDaysVCDelegate
private extension CalendarVC/*: CalendarDaysVCDelegate*/ {
    func _didSelect(_ date: Date, on calendarDaysVC: CalendarDaysVC) {
        self.__selectedDate = date
        self.delegate?.didSelectDate(date, on: self)
    }
}


// MARK: PageViewController Helpers
private extension CalendarVC {
    func _showPreviousMonth() {
        let vc: CalendarDaysVC = self._daysVC(for: self._currentDaysVC.month - 1.month)
        self._switchTo(daysVC: vc, direction: .reverse, animated: false)
    }
    
    func _showNextMonth() {
        let vc: CalendarDaysVC = self._daysVC(for: self._currentDaysVC.month + 1.month)
        self._switchTo(daysVC: vc, direction: .forward, animated: false)
    }
    
    func _switchTo(daysVC: CalendarDaysVC, direction: UIPageViewControllerNavigationDirection, animated: Bool = true) {
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
        daysVC.delegate = self
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
        let month: Date = self._displayedMonthAndYear
        guard !date.isIn(date: month, granularity: .month) else { return }
        let roundedDate: Date = date.startOf(component: .month)
        let vc: CalendarDaysVC = self._daysVC(for: roundedDate)
        
        let isLaterMonth: Bool = roundedDate.isAfter(date: month, granularity: .month)
        let direction: UIPageViewControllerNavigationDirection = isLaterMonth ? .forward : .reverse
        
        self._switchTo(daysVC: vc, direction: direction, animated: animated)
        
        // If the new month is not adjacent to the old one,
        // we need to flush the vc-cash of the pageVC,
        // so the correct month will be shown on the next
        // button tap or swipe.  Unfortunately, it seems
        // as though there's no better way to do this...
        if month >< [roundedDate.prevMonth(at: .auto), roundedDate.nextMonth(at: .auto)] {
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
