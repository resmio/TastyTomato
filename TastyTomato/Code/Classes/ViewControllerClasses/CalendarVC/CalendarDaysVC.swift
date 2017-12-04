//
//  CalendarDaysVC.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 04.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: - CalendarDaysVCDelegate
protocol CalendarDaysVCDelegate: class {}


// MARK: - CalendarDaysVC
// MARK: Interface
// MARK: Class Declaration
class CalendarDaysVC: UIViewController {
    // Private Lazy Variables
    fileprivate lazy var _calendarDaysView: CalendarDaysView = self._createCalendarDaysView()
}


// MARK: Delegates / DataSources
// MARK: CalendarDaysViewDelegate
extension CalendarDaysVC: CalendarDaysViewDelegate {}


// MARK: // Private
// MARK: Lazy Variable Creation
private extension CalendarDaysVC {
    func _createCalendarDaysView() -> CalendarDaysView {
        let calendarDaysView: CalendarDaysView = CalendarDaysView()
        calendarDaysView.delegate = self
        return calendarDaysView
    }
}
