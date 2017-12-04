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
    func tappedLeftArrowButton(on calendarHeaderView: CalendarHeaderView) {}
    func tappedRightArrowButton(on calendarHeaderView: CalendarHeaderView) {}
}


// MARK: UIPageViewControllerDelegate
extension CalendarVC: UIPageViewControllerDelegate {
    
}


// MARK: UIPageViewControllerDataSource
extension CalendarVC: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc: CalendarDaysVC = CalendarDaysVC()
        return vc
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc: CalendarDaysVC = CalendarDaysVC()
        return vc
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
