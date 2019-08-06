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
    
    // All Color Schemes
    static var all: [ColorScheme] {
        return [.light]
    }
    
    // MARK: -
    // MARK: Predefined ColorSchemes
    // MARK: -
    static let light: ColorScheme = ColorScheme(
        _name: "Light",
        _background: Background(
            // MARK: // General
            navigationBar: .blue333B4F, // headerBackgroundColor
            defaultPopover: .whiteFFFFFF, // popoverBackgroundColor
            defaultSelected: .blue00A7C4, // selection / focus
            newBookingFlow: .whiteFFFFFF, // walkIn / newBookingBackgroundColor
            selectButton: .blue00A7C4, // selectButton
            createButton: .blue00A7C4, // createButton
            deleteButton: .redE62C4F, // deleteButton
            switchOn: .blue00A7C4, // switchButtonON
            switchOff: .whiteF7F7F7, // switchButtonOFF
            
            // MARK: // Specific
            // MARK: LoginView
            // FIXME: what does "(background image +)" mean?
            login: .whiteFFFFFF, // SignInBackgroundColor (background image +)
            signInButton: .blue00A7C4, // SignInButton
            
            // MARK: MainMenuView
            mainMenu: .blue333B4F, // navigationbarBackgroundColor
            mainMenuHeader: .blue293140, // navigationbarTopBackgroundColor
            mainMenuSelectedItem: .blue293140, // selectedItemNavigationbarBackgroundColor
            mainMenuSelectedSubItem: .blue00A7C4, // selectedItemNavigationbarBackgroundColor (second hierarchy)
            mainMenuSelectedItemBanner: .blue1E2532, // selectedItemNavigationbarLeftBorderColor
            
            // MARK: BookingsView
            searchFieldContainer: .whiteFFFFFF, // aroundSearchFieldBackgroundColor
            searchField: .whiteF7F7F7, // searchFieldFillColor
            bookingStatusSectionHeader: .whiteFFFFFF, // statusBookingListBackgroundColor
            bookingCell: .whiteF7F7F7, // bookingsBookingListBackgroundColor
            
            // MARK: RoomsView
            // FIXME: roomWithoutFloorBackgroundColor and diningAreasBackgroundColor have been left out,
            // rooms without floor simply have a clear background.
            roomsView: .whiteFFFFFF, // roomAreaBackgroundColor
            
            // MARK: ChooseTablesView
            numOfSeatsInfoPerfect: .green22CCAA, // newBookingSeatsPerfect
            numOfSeatsInfoWarning: .yellowF8C150, // newBookingSeatsAreNeeded /Overlapping
            overlapWarning: .yellowF8C150, // newBookingSeatsAreNeeded /Overlapping
            
            // MARK: TischView
            freeTable: .gray999999, // freeTable
            partiallyOccupiedTable: .green22CCAA, // occupiedTableWithFreeSeats
            fullTable: .blue00A7C4, // fullyOccupiedTableNoSeats
            blockedTableStripe: .gray555555, // blockedTable (stripes)
            chairColor: .gray555555, // Seats
            
            // MARK: TimelineView
            timelineView: .whiteFFFFFF, // timelineBackgroundColor
            timeIndicatorLabel: .blue00A7C4, // timeFocusFillColor
            
            // MARK: SettingsView
            settingsView: .whiteFFFFFF, // settingsBackgroundColor
            
            // MARK: CalendarView
            selectedDay: .blue00A7C4, // BackgroundFilled
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .redE62C4F, // notificationBadgeBackgroundColor
            notificationsView: .whiteFFFFFF, // notificationfeedBackgroundColor
            notificationsViewSectionHeader: .whiteF7F7F7, // notificationfeedheadingsBackgroundColor
            // FIXME: Alpha 0.2?
            noteCell: .blue00A7C4, // notificationfeedNotesBackgroundColor
            // FIXME: Alpha 0.2?
            taskCellUnread: .yellowF8C150, // notificationsfeedNewOpenTasksBackgroundColor
            taskCellRead: .whiteFFFFFF, // notificationsfeedReadOpenTasksBackgroundColor
            
            // MARK: OfflinePopover
            offlineView: .whiteFFFFFF, // noInternetAlertBackgroundColor
            
            // MARK: TableInfoPopover
            tableInfoPopoverButton: .blue333B4F, // buttonInPopover (newBooking/ walkIn/ blocking)
            
            // MARK: SuccessHUD
            successHUD: .green22CCAA // successBackgroundColor
        ),
        _lines: Lines(
            // MARK: // General
            separator: .grayCCCCCC, // separatorColor
            borderUnfocussed: .grayCCCCCC, // borderColor
            borderFocussed: .blue00A7C4, // focusBorderColor
            switchBorder: .grayCCCCCC, // switchButtonOutline
            stepperTint: .gray555555, // minusPlusButton
            segmentedControl: .blue00A7C4, // selectButton
            iconOnLightBackground: .gray555555, // iconsOnWhitebackground
            iconOnDarkBackground: .whiteFFFFFF, // iconsOnDarkbackground
            
            // MARK: // Specific
            // MARK: MainTitleView
            buttonBorder: .blue3E4862, // buttonBorderColor (all, except hamburger)
            hamburgerIcon: .whiteFFFFFF, // hamburgerIcon
            arrowIcon: .whiteFFFFFF, // arrows / time / date
            nowButtonEnabled: .whiteFFFFFF, // nowButtonActiveBorderColor
            nowButtonDisabled: .blue3E4862, // nowButtonBorderInactiveColor
            offlineIcon: .redE62C4F, // noInternetIcon
            notificationButtonDisabled: .blue3E4862, // notificationfeedIconInactive
            notificationButtonNotes: .blue00A7C4, // notificationfeedIconNotes
            notificationButtonNotesAndTasks: .whiteFFFFFF, // notificationfeedIconNotesAndOpenTasks
            newBookingButton: .whiteFFFFFF, // newBooking / walkIn
            newWalkinButton: .whiteFFFFFF, // newBooking / walkIn
            
            // MARK: TimelineView
            horizontalSeparator: .grayCCCCCC, // horizontalSeparatorColor
            verticalSeparator: .blue3E4862, // verticalSeparatorColor (full hours)
            verticalSubSeparator: .grayCCCCCC, // verticalSeparatorColor (quarter & half hour)
            timeIndicatorLine: .blue00A7C4, // timeFocusVerticalLineColor
            
            // MARK: LinkIcon
            linkIconPartiallyOccupiedTable: .green22CCAA, // linkedTableOccupiedFreeSeatsIcon
            linkIconFullTable: .blue00A7C4, // linkedTableFullyOccupiedIcon
        ),
        _text: Text(
            // MARK: // General
            default: .gray999999, // defaultTextColor
            onDarkBackground: .whiteFFFFFF, // darkBackgroundTextColor
            // FIXME: what does the TextColor mean: lightBackgroundTextColor / TextColor
            onLightBackground: .gray555555, // lightBackgroundTextColor / TextColor
            navigationBar: .blue3E4862, // headerTextColor
            // FIXME: what is: public let inputHelp: UIColor
            // FIXME: what is: public let today/highlighted: UIColor
            
            // MARK: // Specific
            // MARK: MainMenuView
            mainMenuSectionHeader: .blue3E4862, // headingTextColor
            mainMenuItem: .grayDDDDDD, // navigationBarTextColor
            mainMenuSelectedItem: .whiteFFFFFF, // selectedItemNavigationsBarTextColor
            
            // MARK: MainTitleView
            mainTitleView: .whiteFFFFFF, // arrows / time / date
            // FIXME: I've left out nowButtonActive and nowButtonInactive
            // since they are in both color schemes similar to the
            // border colors of the enabled/disabled states
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .whiteFFFFFF, // notificationBadgeTextColor
            notificationsViewSectionHeader: .gray555555, // notificationfeedHeadingColor
            notesCell: .blue018EA6, // notificationfeedNoteTextColor
            taskCellUnread: .yellowD7A43B, // notificationfeedNewOpenTasksTextColor
            taskCellRead: .gray555555, // notificationsfeedReadOpenTasksBackgroundColor
            
            // MARK: TischView
            partiallyOccupiedTable: .green22CCAA, // occupiedTableWithFreeSeats
            fullTable: .blue00A7C4, // occupiedTableNoSeats
            blocking: .redE62C4F, // blocking
            
            // MARK: CalendarView
            monthHeading: .gray555555, // monthHeadingTextColor
            weekdayName: .gray555555, // weekdayLabelsTextColor
            pastDay: .grayCCCCCC, // pastDaysTextColor
            today: .blue00A7C4, // todayTextColor
            selectedDay: .whiteFFFFFF, // selectedDayTextColor
            dateInCurrentMonth: .gray555555, // currentMonthDaysTextColor
            dateInOtherMonth: .gray999999, // nextMonthDatesTextColor
            
            // MARK: TimelineView
            timeIndicatorLabel: .whiteFFFFFF, // timeFocusTextColor (time)
            
            // MARK: TextButtons
            saveButton: .green22CCAA, // saveButton
            cancelButton: .redE62C4F, // cancelButton
            nextButton: .whiteFFFFFF, // nextButton
            backButton: .whiteFFFFFF, // backButton
            doneButton: .green22CCAA, // doneButton
            newButton: .blue00A7C4, // newButton
            editButton: .blue00A7C4 // editButton
        ),
        _bookingStatus: BookingStatus(
            unconfirmed: .yellowD7A43B, // Unconfirmed
            confirmed: .blue00A7C4, // Confirmed
            arrived: .green22CCAA, // Arrived
            seated: .yellowF8C150, // Seated
            finished: .gray999999, // Finished
            noShow: .blue3E4862, // No-Show
            cancelled: .redE62C4F // Cancelled
        )
    )

//    static let dark: ColorScheme = ColorScheme(
//        _name: "Dark",
//    )
}


// MARK: -
// MARK: -
// MARK: Class Declaration
@objc public class ColorScheme: NSObject {
    // Private Init
    private init(_name: String, _background: Background, _lines: Lines, _text: Text, _bookingStatus: BookingStatus) {
        self.name = _name
        self.background = _background
        self.lines = _lines
        self.text = _text
        self.bookingStatus = _bookingStatus
    }
    
    // Public Static Constants
    public static let currentSchemeChanged: Notification.Name = Notification.Name(rawValue: "TastyTomato.ColorScheme.currentSchemeChanged")
    
    // Private Static Variables
    private static var __current: ColorScheme = .light

    // Public Constants
    public let name: String
    
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
        // MARK: // General
        public let navigationBar: UIColor
        public let defaultPopover: UIColor
        public let defaultSelected: UIColor
        public let newBookingFlow: UIColor
        public let selectButton: UIColor
        public let createButton: UIColor
        public let deleteButton: UIColor
        public let switchOn: UIColor
        public let switchOff: UIColor
        
        // MARK: // Specific
        // MARK: LoginView
        public let login: UIColor
        public let signInButton: UIColor
        
        // MARK: MainMenuView
        public let mainMenu: UIColor
        public let mainMenuHeader: UIColor
        public let mainMenuSelectedItem: UIColor
        public let mainMenuSelectedSubItem: UIColor
        public let mainMenuSelectedItemBanner: UIColor
        
        // MARK: BookingsView
        public let searchFieldContainer: UIColor
        public let searchField: UIColor
        public let bookingStatusSectionHeader: UIColor
        public let bookingCell: UIColor
        
        // MARK: RoomsView
        public let roomsView: UIColor
        
        // MARK: ChooseTablesView
        public let numOfSeatsInfoPerfect: UIColor
        public let numOfSeatsInfoWarning: UIColor
        public let overlapWarning: UIColor
        
        // MARK: TischView
        public let freeTable: UIColor
        public let partiallyOccupiedTable: UIColor
        public let fullTable: UIColor
        public let blockedTableStripe: UIColor
        public let chairColor: UIColor
        
        // MARK: TimelineView
        public let timelineView: UIColor
        public let timeIndicatorLabel: UIColor
        
        // MARK: SettingsView
        public let settingsView: UIColor
        
        // MARK: CalendarView
        public let selectedDay: UIColor
        
        // MARK: NotificationsPopover
        public let notificationButtonBadge: UIColor
        public let notificationsView: UIColor
        public let notificationsViewSectionHeader: UIColor
        public let noteCell: UIColor
        public let taskCellUnread: UIColor
        public let taskCellRead: UIColor
        
        // MARK: OfflinePopover
        public let offlineView: UIColor
        
        // MARK: TableInfoPopover
        public let tableInfoPopoverButton: UIColor
        
        // MARK: SuccessHUD
        public let successHUD: UIColor
    }
    
    struct Lines {
        // MARK: // General
        public let separator: UIColor
        public let borderUnfocussed: UIColor
        public let borderFocussed: UIColor
        public let switchBorder: UIColor
        public let stepperTint: UIColor
        public let segmentedControl: UIColor
        public let iconOnLightBackground: UIColor
        public let iconOnDarkBackground: UIColor
        
        // MARK: // Specific
        // MARK: MainTitleView
        public let buttonBorder: UIColor
        public let hamburgerIcon: UIColor
        public let arrowIcon: UIColor
        public let nowButtonEnabled: UIColor
        public let nowButtonDisabled: UIColor
        public let offlineIcon: UIColor
        public let notificationButtonDisabled: UIColor
        public let notificationButtonNotes: UIColor
        public let notificationButtonNotesAndTasks: UIColor
        public let newBookingButton: UIColor
        public let newWalkinButton: UIColor
        
        // MARK: TimelineView
        public let horizontalSeparator: UIColor
        public let verticalSeparator: UIColor
        public let verticalSubSeparator: UIColor
        public let timeIndicatorLine: UIColor
        
        // MARK: LinkIcon
        public let linkIconPartiallyOccupiedTable: UIColor
        public let linkIconFullTable: UIColor
    }
    
    struct Text {
        // MARK: // General
        public let `default`: UIColor
        public let onDarkBackground: UIColor
        public let onLightBackground: UIColor
        public let navigationBar: UIColor
        // FIXME: public let inputHelp: UIColor
        // FIXME: public let today/highlighted: UIColor
        
        // MARK: // Specific
        // MARK: MainMenuView
        public let mainMenuSectionHeader: UIColor
        public let mainMenuItem: UIColor
        public let mainMenuSelectedItem: UIColor
        
        // MARK: MainTitleView
        public let mainTitleView: UIColor
        
        // MARK: NotificationsPopover
        public let notificationButtonBadge: UIColor
        public let notificationsViewSectionHeader: UIColor
        public let notesCell: UIColor
        public let taskCellUnread: UIColor
        public let taskCellRead: UIColor
        
        // MARK: TischView
        public let partiallyOccupiedTable: UIColor
        public let fullTable: UIColor
        public let blocking: UIColor
        
        // MARK: CalendarView
        public let monthHeading: UIColor
        public let weekdayName: UIColor
        public let pastDay: UIColor
        public let today: UIColor
        public let selectedDay: UIColor
        public let dateInCurrentMonth: UIColor
        public let dateInOtherMonth: UIColor
        
        // MARK: TimelineView
        public let timeIndicatorLabel: UIColor
        
        // MARK: TextButtons
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
