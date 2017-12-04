//
//  CalendarVC.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 30.11.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: - CalendarVCDelegate
public protocol CalendarVCDelegate: class {
    func didSelectDate(_ date: Date, on calendarVC: CalendarVC)
}


// MARK: - CalendarVC
// MARK: Interface
public extension CalendarVC {
    var delegate: CalendarVCDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
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
    fileprivate var _currentDaysVC: CalendarDaysVC?
    fileprivate var _isPaging: Bool = false
    
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
        return self._daysVC(.before, (viewController as! CalendarDaysVC))
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self._daysVC(.after, (viewController as! CalendarDaysVC))
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
        
        let initialVC: CalendarDaysVC = CalendarDaysVC()
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
        self._currentDaysVC = (pendingViewControllers[0] as! CalendarDaysVC)
    }
}


// MARK: PageViewController Helpers
private extension CalendarVC {
    enum _Direction {
        case before, after
    }
    
    func _daysVC(_ direction: _Direction, _ vc: CalendarDaysVC) -> CalendarDaysVC {
        return CalendarDaysVC()
    }
    
    func _showPreviousMonth() {
        guard !self._isPaging else { return }
        guard let currentVC: CalendarDaysVC = self._currentDaysVC else { return }
        
        self._isPaging = true
        self._pageVC.setViewControllers(
            [self._daysVC(.before, currentVC)],
            direction: .reverse,
            animated: true,
            completion: { _ in
                self._isPaging = false
            }
        )
    }
    
    func _showNextMonth() {
        guard !self._isPaging else { return }
        guard let currentVC: CalendarDaysVC = self._currentDaysVC else { return }
        
        self._isPaging = true
        self._pageVC.setViewControllers(
            [self._daysVC(.after, currentVC)],
            direction: .forward,
            animated: true,
            completion: { _ in
                self._isPaging = false
            }
        )
    }
}
