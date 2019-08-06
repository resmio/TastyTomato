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
        public let navigationBar: UIColor
        public let defaultPopover: UIColor
        public let defaultSelected: UIColor
        public let newBookingFlow: UIColor
        public let selectButton: UIColor
        public let createButton: UIColor
        public let deleteButton: UIColor
        public let switchOn: UIColor
        public let switchOff: UIColor
        
        // // Specific
        // LoginView
        public let login: UIColor
        public let signInButton: UIColor
        
        // MainMenuView
        public let mainMenu: UIColor
        public let mainMenuHeader: UIColor
        public let mainMenuSelectedItem: UIColor
        public let mainMenuSelectedSubItem: UIColor
        public let mainMenuSelectedItemBanner: UIColor
        
        // BookingsView
        public let searchFieldContainer: UIColor
        public let searchField: UIColor
        public let bookingCell: UIColor
        
        // RoomsView
        public let roomsView: UIColor
        
        // ChooseTablesView
        public let numOfSeatsInfoPerfect: UIColor
        public let numOfSeatsInfoWarning: UIColor
        public let overlapWarning: UIColor
        
        // TischView
        public let freeTable: UIColor
        public let partiallyOccupiedTable: UIColor
        public let fullTable: UIColor
        public let blockedTableStripe: UIColor
        public let chairColor: UIColor
        
        // TimelineView
        public let timelineView: UIColor
        public let timeIndicatorLabel: UIColor
        
        // SettingsView
        public let settingsView: UIColor
        
        // CalendarView
        public let selectedDay: UIColor
        
        // NotificationsPopover
        public let notificationButtonBadge: UIColor
        public let notificationsView: UIColor
        public let notificationsViewSectionHeader: UIColor
        public let noteCell: UIColor
        public let taskCellUnread: UIColor
        public let taskCellRead: UIColor
        
        // OfflinePopover
        public let offlineView: UIColor
        public let successHUD: UIColor
    }
    
    struct Lines {
        // // General
        public let separator: UIColor
        public let borderUnfocussed: UIColor
        public let borderFocussed: UIColor
        public let buttonBorder: UIColor
        // FIXME: public let switchBorder: UIColor
        public let stepper: UIColor
        public let segmentedControl: UIColor
        public let iconOnLightBackground: UIColor
        public let iconOnDarkBackground: UIColor
        
        // // Specific
        // MainTitleView
        public let hamburgerIcon: UIColor
        public let arrowIcon: UIColor
        public let nowButtonDisabled: UIColor
        public let offlineIcon: UIColor
        public let notificationButtonDisabled: UIColor
        public let notificationButtonNotes: UIColor
        public let notificationButtonNotesAndTasks: UIColor
        public let newBookingButton: UIColor
        public let newWalkinButton: UIColor
        
        // TimelineView
        public let horizontalSeparator: UIColor
        public let verticalSeparator: UIColor
        public let verticalSubSeparator: UIColor
        public let timeIndicatorLine: UIColor
    }
    
    struct Text {
        // // General
        public let defaultText: UIColor
        public let onDarkBackground: UIColor
        public let onLightBackground: UIColor
        public let navigationBar: UIColor
        // FIXME: public let inputHelp: UIColor
        // FIXME: public let today/highlighted: UIColor
        
        // // Specific
        // MainMenuView
        public let mainMenuItem: UIColor
        public let mainMenuSelectedItem: UIColor
        
        // MainTitleView
        public let nowButtonEnabled: UIColor
        public let nowButtonDisabled: UIColor
        
        // NotificationsPopover
        public let notificationButtonBadge: UIColor
        public let notificationsViewSectionHeader: UIColor
        public let notesCell: UIColor
        public let taskCellUnread: UIColor
        public let taskCellRead: UIColor
        
        // TischView
        public let partiallyOccupiedTable: UIColor
        public let fullTable: UIColor
        public let blocking: UIColor
        
        // CalendarView
        public let monthHeading: UIColor
        public let weekdayName: UIColor
        public let pastDay: UIColor
        public let today: UIColor
        public let selectedDay: UIColor
        public let dateInCurrentMonth: UIColor
        public let dateInOtherMonth: UIColor
        
        // TextButtons
        public let saveButton: UIColor
        public let cancelButton: UIColor
        public let nextButton: UIColor
        public let backButton: UIColor
        public let doneButton: UIColor
        public let newButton: UIColor
        public let editButton: UIColor
    }
    
    struct BookingStatus {
        public let unconfirmed: UIColor
        public let confirmed: UIColor
        public let arrived: UIColor
        public let seated: UIColor
        public let finished: UIColor
        public let noShow: UIColor
        public let cancelled: UIColor
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
