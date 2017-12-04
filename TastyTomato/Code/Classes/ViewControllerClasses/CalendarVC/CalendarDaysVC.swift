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
extension CalendarDaysVC {
    var delegate: CalendarDaysVCDelegate? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
}


// MARK: Class Declaration
class CalendarDaysVC: UIViewController {
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarDaysVCDelegate?
    
    // Private Lazy Variables
    fileprivate lazy var _calendarDaysView: CalendarDaysView = self._createCalendarDaysView()
    
    // Layout Overrides
    override func loadView() {
        self.view = self._calendarDaysView
    }
}


// MARK: Delegates / DataSources
// MARK: CalendarDaysViewDelegate
extension CalendarDaysVC: CalendarDaysViewDelegate {
    func configure(_ dateCell: DateCell, for indexPath: IndexPath) {
        
    }
    
    func shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func didSelect(_ dateCell: DateCell, at indexPath: IndexPath) {
        
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
