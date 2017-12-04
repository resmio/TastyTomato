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
    fileprivate lazy var _calendarHeaderView: CalendarHeaderView = self._createCalendarHeaderView()
    fileprivate lazy var _calendarDaysView: CalendarDaysView = self._createCalendarDaysView()
    
    // Lifecycle Overrides
    public override func loadView() {
        self.view = self._calendarVCView
    }
}


// MARK: Delegates / DataSources
// MARK: CalendarHeaderViewDelegate
extension CalendarVC: CalendarHeaderViewDelegate {
    func tappedLeftArrowButton(on calendarHeaderView: CalendarHeaderView) {}
    func tappedRightArrowButton(on calendarHeaderView: CalendarHeaderView) {}
}


// MARK: CalendarDaysViewDelegate
extension CalendarVC: CalendarDaysViewDelegate {
    
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarVC {
    func _createCalendarVCView() -> CalendarVCView {
        let calendarVCView: CalendarVCView = CalendarVCView()
        calendarVCView.headerView = self._calendarHeaderView
        calendarVCView.pageVCView = self._calendarDaysView
        return calendarVCView
    }
    
    func _createCalendarHeaderView() -> CalendarHeaderView {
        let calendarHeaderView: CalendarHeaderView = CalendarHeaderView()
        calendarHeaderView.delegate = self
        return calendarHeaderView
    }
    
    func _createCalendarDaysView() -> CalendarDaysView {
        let calendarDaysView: CalendarDaysView = CalendarDaysView()
        calendarDaysView.delegate = self
        return calendarDaysView
    }
}
