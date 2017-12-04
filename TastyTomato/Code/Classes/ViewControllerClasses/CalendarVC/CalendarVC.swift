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
    fileprivate lazy var _calendarDaysView: CalendarDaysView = self._createCalendarDaysView()
    
    // Lifecycle Overrides
    public override func loadView() {
        self.view = self._calendarDaysView
    }
}


// MARK: Delegates / DataSources
// MARK: CalendarDaysViewDelegate
extension CalendarVC: CalendarDaysViewDelegate {
    
}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarVC {
    func _createCalendarDaysView() -> CalendarDaysView {
        let calendarDaysView: CalendarDaysView = CalendarDaysView()
        calendarDaysView.delegate = self
        return calendarDaysView
    }
}
