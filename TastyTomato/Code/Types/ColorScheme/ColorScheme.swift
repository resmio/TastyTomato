//
//  ColorScheme.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 01.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Interface
@objc public extension ColorScheme {
    // Current ColorScheme
    static var current: ColorScheme {
        get { return self.__current }
        set { self._setCurrentScheme(newValue) }
    }
    
    // Predefined ColorSchemes
    static let light: ColorScheme = ColorScheme(
        _background: Background(
            navigationBar: .blue333B4F,
            defaultPopover: .whiteFFFFFF,
            defaultSelected: .blue00A7C4,
            newBookingFlow: .whiteFFFFFF,
            selectButton: .blue00A7C4,
            createButton: .blue00A7C4,
            deleteButton: .redE62C4F,
            switchOn: .blue00A7C4,
            switchOff: .whiteF7F7F7,
            login: .whiteFFFFFF,
            signInButton: .blue00A7C4,
            mainMenu: .blue333B4F,
            mainMenuHeader: .blue293140,
            mainMenuSelectedItem: .blue293140,
            mainMenuSelectedSubItem: .blue00A7C4,
            mainMenuSelectedItemBanner: .blue1E2532,
            searchFieldContainer: .whiteFFFFFF,
            searchField: .whiteF7F7F7,
            bookingCell: .whiteF7F7F7,
            roomsView: .whiteFFFFFF,
            numOfSeatsInfoPerfect: .green22CCAA,
            numOfSeatsInfoWarning: .yellowF8C150,
            overlapWarning: .yellowF8C150,
            freeTable: .gray999999,
            partiallyOccupiedTable: .green22CCAA,
            fullTable: .blue00A7C4,
            blockedTableStripe: .gray555555,
            chairColor: .gray555555,
            timelineView: .whiteFFFFFF,
            timeIndicatorLabel: .blue00A7C4,
            settingsView: .whiteFFFFFF,
            selectedDay: .blue00A7C4,
            notificationButtonBadge: .redE62C4F,
            notificationsView: .whiteFFFFFF,
            notificationsViewSectionHeader: .whiteF7F7F7,
            noteCell: .blue00A7C4, // FIXME: Alpha 0.2?
            taskCellUnread: .yellowF8C150, // FIXME: Alpha 0.2?
            taskCellRead: .whiteFFFFFF,
            offlineView: .whiteFFFFFF,
            successHUD: .green22CCAA
        ),
        _lines: Lines(
            separator: .grayCCCCCC,
            borderUnfocussed: .grayCCCCCC,
            borderFocussed: .blue00A7C4,
            buttonBorder: .blue3E4862, // FIXME: This should be 3F4962
            stepper: .gray555555,
            segmentedControl: .blue00A7C4,
            iconOnLightBackground: .gray555555,
            iconOnDarkBackground: .whiteFFFFFF,
            hamburgerIcon: .whiteFFFFFF,
            arrowIcon: .whiteFFFFFF,
            nowButtonDisabled: .blue3E4862, // FIXME: This should be 3F4962
            offlineIcon: .redE62C4F,
            notificationButtonDisabled: .blue3E4862,
            notificationButtonNotes: .blue00A7C4,
            notificationButtonNotesAndTasks: .whiteFFFFFF,
            newBookingButton: .whiteFFFFFF,
            newWalkinButton: .whiteFFFFFF,
            horizontalSeparator: .grayCCCCCC,
            verticalSeparator: .blue3E4862, // FIXME: This should be 3F4962
            verticalSubSeparator: .grayCCCCCC,
            timeIndicatorLine: .blue00A7C4
        ),
        _text: Text(
            defaultText: .gray999999,
            onDarkBackground: .whiteFFFFFF,
            onLightBackground: .gray555555,
            navigationBar: .blue3E4862, // FIXME: This should be 3F4962
            mainMenuItem: .grayDDDDDD,
            mainMenuSelectedItem: .whiteFFFFFF,
            nowButtonEnabled: .whiteFFFFFF,
            nowButtonDisabled: .blue3E4862, // FIXME: This should be 3F4962
            notificationButtonBadge: .whiteFFFFFF,
            notificationsViewSectionHeader: .gray555555,
            notesCell: .blue018EA6,
            taskCellUnread: .yellowD7A43B,
            taskCellRead: .gray555555,
            partiallyOccupiedTable: .green22CCAA,
            fullTable: .blue00A7C4,
            blocking: .redE62C4F,
            monthHeading: .gray555555,
            weekdayName: .gray555555,
            pastDay: .grayCCCCCC,
            today: .blue00A7C4,
            selectedDay: .whiteFFFFFF,
            dateInCurrentMonth: .gray555555,
            dateInOtherMonth: .gray999999,
            saveButton: .green22CCAA,
            cancelButton: .redE62C4F,
            nextButton: .whiteFFFFFF,
            backButton: .whiteFFFFFF,
            doneButton: .green22CCAA,
            newButton: .blue00A7C4,
            editButton: .blue00A7C4
        ),
        _bookingStatus: BookingStatus(
            unconfirmed: .yellowD7A43B,
            confirmed: .blue00A7C4,
            arrived: .green22CCAA,
            seated: .yellowF8C150,
            finished: .gray999999,
            noShow: .blue3E4862,
            cancelled: .redE62C4F
        )
    )

    //    static let dark: ColorScheme = ColorScheme()
}


// MARK: Class Declaration
@objc public class ColorScheme: NSObject {
    // Private Init
    private init(_background: Background, _lines: Lines, _text: Text, _bookingStatus: BookingStatus) {
        self.background = _background
        self.lines = _lines
        self.text = _text
        self.bookingStatus = _bookingStatus
    }
    
    // Public Static Constants
    public static let currentSchemeChanged: Notification.Name = Notification.Name(rawValue: "TastyTomato.ColorScheme.currentSchemeChanged")
    
    // Private Static Variables
    private static var __current: ColorScheme = .light

    // Public Readonly Variables
    public private(set) var background: Background
    public private(set) var lines: Lines
    public private(set) var text: Text
    public private(set) var bookingStatus: BookingStatus
}


// MARK: Nested Types
// MARK: Background
public extension ColorScheme {
    // Nested Types
    struct Background {
        // // General
        let navigationBar: UIColor
        let defaultPopover: UIColor
        let defaultSelected: UIColor
        let newBookingFlow: UIColor
        let selectButton: UIColor
        let createButton: UIColor
        let deleteButton: UIColor
        let switchOn: UIColor
        let switchOff: UIColor
        
        // // Specific
        // LoginView
        let login: UIColor
        let signInButton: UIColor
        
        // MainMenuView
        let mainMenu: UIColor
        let mainMenuHeader: UIColor
        let mainMenuSelectedItem: UIColor
        let mainMenuSelectedSubItem: UIColor
        let mainMenuSelectedItemBanner: UIColor
        
        // BookingsView
        let searchFieldContainer: UIColor
        let searchField: UIColor
        let bookingCell: UIColor
        
        // RoomsView
        let roomsView: UIColor
        
        // ChooseTablesView
        let numOfSeatsInfoPerfect: UIColor
        let numOfSeatsInfoWarning: UIColor
        let overlapWarning: UIColor
        
        // TischView
        let freeTable: UIColor
        let partiallyOccupiedTable: UIColor
        let fullTable: UIColor
        let blockedTableStripe: UIColor
        let chairColor: UIColor
        
        // TimelineView
        let timelineView: UIColor
        let timeIndicatorLabel: UIColor
        
        // SettingsView
        let settingsView: UIColor
        
        // CalendarView
        let selectedDay: UIColor
        
        // NotificationsPopover
        let notificationButtonBadge: UIColor
        let notificationsView: UIColor
        let notificationsViewSectionHeader: UIColor
        let noteCell: UIColor
        let taskCellUnread: UIColor
        let taskCellRead: UIColor
        
        // OfflinePopover
        let offlineView: UIColor
        let successHUD: UIColor
    }
    
    struct Lines {
        // // General
        let separator: UIColor
        let borderUnfocussed: UIColor
        let borderFocussed: UIColor
        let buttonBorder: UIColor
        // FIXME: let switchBorder: UIColor
        let stepper: UIColor
        let segmentedControl: UIColor
        let iconOnLightBackground: UIColor
        let iconOnDarkBackground: UIColor
        
        // // Specific
        // MainTitleView
        let hamburgerIcon: UIColor
        let arrowIcon: UIColor
        let nowButtonDisabled: UIColor
        let offlineIcon: UIColor
        let notificationButtonDisabled: UIColor
        let notificationButtonNotes: UIColor
        let notificationButtonNotesAndTasks: UIColor
        let newBookingButton: UIColor
        let newWalkinButton: UIColor
        
        // TimelineView
        let horizontalSeparator: UIColor
        let verticalSeparator: UIColor
        let verticalSubSeparator: UIColor
        let timeIndicatorLine: UIColor
    }
    
    struct Text {
        // // General
        let defaultText: UIColor
        let onDarkBackground: UIColor
        let onLightBackground: UIColor
        let navigationBar: UIColor
        // FIXME: let inputHelp: UIColor
        // FIXME: let today/highlighted: UIColor
        
        // // Specific
        // MainMenuView
        let mainMenuItem: UIColor
        let mainMenuSelectedItem: UIColor
        
        // MainTitleView
        let nowButtonEnabled: UIColor
        let nowButtonDisabled: UIColor
        
        // NotificationsPopover
        let notificationButtonBadge: UIColor
        let notificationsViewSectionHeader: UIColor
        let notesCell: UIColor
        let taskCellUnread: UIColor
        let taskCellRead: UIColor
        
        // TischView
        let partiallyOccupiedTable: UIColor
        let fullTable: UIColor
        let blocking: UIColor
        
        // CalendarView
        let monthHeading: UIColor
        let weekdayName: UIColor
        let pastDay: UIColor
        let today: UIColor
        let selectedDay: UIColor
        let dateInCurrentMonth: UIColor
        let dateInOtherMonth: UIColor
        
        // TextButtons
        let saveButton: UIColor
        let cancelButton: UIColor
        let nextButton: UIColor
        let backButton: UIColor
        let doneButton: UIColor
        let newButton: UIColor
        let editButton: UIColor
    }
    
    struct BookingStatus {
        let unconfirmed: UIColor
        let confirmed: UIColor
        let arrived: UIColor
        let seated: UIColor
        let finished: UIColor
        let noShow: UIColor
        let cancelled: UIColor
    }
}


// MARK: // Private
// MARK: Setters
private extension ColorScheme {
    static func _setCurrentScheme(_ currentScheme: ColorScheme) {
        guard currentScheme != self.__current else { return }
        self.__current = currentScheme
        NotificationCenter.default.post(name: self.currentSchemeChanged, object: nil)
    }
}
