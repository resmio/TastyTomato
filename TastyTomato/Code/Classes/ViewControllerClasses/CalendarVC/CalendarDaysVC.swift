//
//  CalendarDaysVC.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 08.12.17.
//  Copyright © 2017 resmio. All rights reserved.
//

import UIKit


// MARK: // Internal
// MARK: - CalendarDaysVCDelegate
protocol CalendarDaysVCDelegate: class {
    func configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysVC: CalendarDaysVC)
    func shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysVC: CalendarDaysVC) -> Bool
    func didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysVC: CalendarDaysVC)
}


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
    // Required Init
    required init?(coder aDecoder: NSCoder) {
        let month: Date = Date().startOf(component: .month)
        self._month = month
        self.calendarDaysView.title = month.string(custom: "MMMM YYYY")
        super.init(coder: aDecoder)
    }
    
    // Init
    init(month: Date) {
        self._month = month
        self.calendarDaysView.title = month.string(custom: "MMMM YYYY")
        super.init(nibName: nil, bundle: nil)
    }
    
    // Private Constants
    fileprivate let calendarDaysView: CalendarDaysView = CalendarDaysView()
    
    // Private Weak Variables
    fileprivate weak var _delegate: CalendarDaysVCDelegate?
    
    // Private Variables
    fileprivate var _month: Date
    
    // Lifecycle Override
    override func loadView() {
        self.view = self.calendarDaysView
    }
}


// MARK: Delegates / DataSources
// MARK: CalendarDaysViewDelegate
extension CalendarDaysVC: CalendarDaysViewDelegate {
    func configure(_ dateCell: DateCell, for indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        self.delegate?.configure(dateCell, for: indexPath, on: self)
    }
    
    func shouldSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) -> Bool {
        self.delegate?.shouldSelect(dateCell, at: indexPath, on: self)
    }
    
    func didSelect(_ dateCell: DateCell, at indexPath: IndexPath, on calendarDaysView: CalendarDaysView) {
        self.delegate?.didSelect(dateCell, at: indexPath, on: self)
    }
}
