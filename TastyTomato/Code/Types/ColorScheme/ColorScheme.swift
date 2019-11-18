//
//  ColorScheme.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 01.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Objc Extrawurst
@objc public extension ColorScheme {
    static var defaultBackground: UIColor {
        return self.background.default
    }
    
    static var switchOnTint: UIColor {
        return self.lines.switchOnTint
    }
    
    static var titleText: UIColor {
        return self.text.titleLabel
    }
    
    static var valueText: UIColor {
        return self.text.valueLabel
    }
    
    static var placeholderText: UIColor {
        return self.text.placeholder
    }
}


// MARK: Interface
public extension ColorScheme {
    // Current ColorScheme
    static var current: ColorScheme {
        get { return self.__current }
        set { self._setCurrentScheme(newValue) }
    }
    
    // All Color Schemes
    static var all: [ColorScheme] {
        return [.light, .dark]
    }
}


// MARK: nonobjc Shorthands
@nonobjc public extension ColorScheme {
    static var background: Background {
        return self.current.background
    }
    
    static var lines: Lines {
        return self.current.lines
    }
    
    static var text: Text {
        return self.current.text
    }
    
    static var bookingStatus: BookingStatus {
        return self.current.bookingStatus
    }
}


// MARK: -
// MARK: -
// MARK: Class Declaration
@objc public class ColorScheme: NSObject {
    // Internal Init
    internal init(name_: String, background_: Background, lines_: Lines, text_: Text, bookingStatus_: BookingStatus) {
        self.name = name_
        self.background = background_
        self.lines = lines_
        self.text = text_
        self.bookingStatus = bookingStatus_
    }
    
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
        public let `default`: UIColor
        public let navigationBar: UIColor
        public let defaultPopover: UIColor
        public let defaultSelected: UIColor
        public let addBookingFlow: UIColor
        public let filledButton: UIColor
        public let filledButtonDimmed: UIColor
        public let createButton: UIColor
        public let deleteButton: UIColor
        public let warning: UIColor
        public let criticalWarning: UIColor
        
        // MARK: // Specific
        // MARK: MainTitleView
        public let nowButtonEnabled: UIColor
        
        // MARK: LoginView
        public let login: UIColor
        
        // MARK: MainMenuView
        public let mainMenu: UIColor
        public let mainMenuHeader: UIColor
        public let mainMenuSelectedItem: UIColor
        public let mainMenuSelectedItemBanner: UIColor
        
        // MARK: SettingsMenuView
        public let settingsMenu: UIColor
        public let settingsMenuSelectedItem: UIColor
        public let settingsMenuSelectedItemBanner: UIColor
        
        // MARK: BookingsView
        public let searchFieldContainer: UIColor
        public let searchField: UIColor
        public let bookingStatusSectionHeader: UIColor
        public let bookingCell: UIColor
        
        // MARK: RoomsView
        public let roomsView: UIColor
        
        // MARK: ChooseTablesView
        public let numOfSeatsInfoPerfect: UIColor
        
        // MARK: TischView
        public let freeTable: UIColor
        public let partiallyOccupiedTable: UIColor
        public let fullTable: UIColor
        public let blockedTableStripe: UIColor
        public let chairColor: UIColor
        
        // MARK: TimelineView
        public let timelineView: UIColor
        public let timeIndicatorLabel: UIColor
        public let timelineNumOfSeatsLabel: UIColor
        
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
        public let switchTint: UIColor
        public let switchOnTint: UIColor
        public let stepperTint: UIColor
        public let sliderTint: UIColor
        public let segmentedControl: UIColor
        public let defaultIcon: UIColor
        public let invertedIcon: UIColor
        public let contrastIcon: UIColor
        public let highlighted: UIColor
        public let warning: UIColor
        public let criticalWarning: UIColor
        public let navBarButtonDisabled: UIColor
        public let filledNextButtonImage: UIColor
        
        // MARK: // Specific
        // MARK: MainTitleView
        public let mainTitleViewButtonBorder: UIColor
        public let hamburgerIcon: UIColor
        public let mainTitleViewArrowIcon: UIColor
        public let nowButtonEnabled: UIColor
        public let offlineIcon: UIColor
        public let notificationButtonDisabled: UIColor
        public let notificationButtonNotes: UIColor
        public let notificationButtonNotesAndTasks: UIColor
        public let newBookingButton: UIColor
        public let newWalkinButton: UIColor
        
        // MARK: MainMenuView
        public let mainMenuHeaderSeparator: UIColor
        
        // MARK: TimelineView
        public let horizontalSeparator: UIColor
        public let verticalSeparator: UIColor
        public let verticalSubSeparator: UIColor
        public let timeIndicatorLine: UIColor
        
        // MARK: LinkIcon
        public let linkIconPartiallyOccupiedTable: UIColor
        public let linkIconFullTable: UIColor
        
        // MARK: OfflinePopover
        public let offlineViewBorder: UIColor
    }
    
    struct Text {
        // MARK: // General
        public let `default`: UIColor
        public let inverted: UIColor
        public let navigationBar: UIColor
        public let titleLabel: UIColor
        public let descriptionLabel: UIColor
        public let valueLabel: UIColor
        public let placeholder: UIColor
        public let highlighted: UIColor
        public let filledButton: UIColor
        public let warningTextView: UIColor
        
        // MARK: // Specific
        // MARK: MainMenuView
        public let mainMenuHeader: UIColor
        public let mainMenuItem: UIColor
        public let mainMenuSelectedItem: UIColor
        
        // MARK: SettingsMenuView
        public let settingsMenuItem: UIColor
        public let settingsMenuSelectedItem: UIColor
        
        // MARK: MainTitleView
        public let mainTitleView: UIColor
        
        // MARK: NotificationsPopover
        public let notificationButtonBadge: UIColor
        public let notificationsViewSectionHeader: UIColor
        public let noteCell: UIColor
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
        public let dateInPast: UIColor
        
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
        public let deleteButton: UIColor
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
        UIView.adjustColorsOfAllRegisteredViews()
    }
}
