//
//  Light.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 07.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
@objc public extension ColorScheme {
    static let light: ColorScheme = ColorScheme(
        name_: "Light",
        
        // MARK: -
        // MARK: // Background
        background_: Background(
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
            disabledFilledButton: UIColor.blue00A7C4.withAlpha(0.2),
            
            // MARK: // Specific
            // MARK: LoginView
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
            noteCell: UIColor.blue00A7C4.withAlpha(0.2), // notificationfeedNotesBackgroundColor
            taskCellUnread: UIColor.yellowF8C150.withAlpha(0.2), // notificationsfeedNewOpenTasksBackgroundColor
            taskCellRead: .whiteFFFFFF, // notificationsfeedReadOpenTasksBackgroundColor
            
            // MARK: OfflinePopover
            offlineView: .whiteFFFFFF, // noInternetAlertBackgroundColor
            
            // MARK: TableInfoPopover
            tableInfoPopoverButton: .blue333B4F, // buttonInPopover (newBooking/ walkIn/ blocking)
            
            // MARK: SuccessHUD
            successHUD: .green22CCAA // successBackgroundColor
        ),
        
        // MARK: -
        // MARK: // Lines
        lines_: Lines(
            // MARK: // General
            separator: .grayCCCCCC, // separatorColor
            borderUnfocussed: .grayCCCCCC, // borderColor
            borderFocussed: .blue00A7C4, // focusBorderColor
            switchBorder: .grayCCCCCC, // switchButtonOutline
            stepperTint: .gray555555, // minusPlusButton
            segmentedControl: .blue00A7C4, // selectButton
            defaultIcon: .gray555555, // iconsOnWhitebackground
            invertedIcon: .whiteFFFFFF, // iconsOnDarkbackground
            highlighted: .blue00A7C4, // today/highlightedTextColor
            
            // MARK: // Specific
            // MARK: MainTitleView
            buttonBorder: .blue3F4962, // buttonBorderColor (all, except hamburger)
            hamburgerIcon: .whiteFFFFFF, // hamburgerIcon
            arrowIcon: .whiteFFFFFF, // arrows / time / date
            nowButtonEnabled: .whiteFFFFFF, // nowButtonActiveBorderColor
            nowButtonDisabled: .blue3F4962, // nowButtonBorderInactiveColor
            offlineIcon: .redE62C4F, // noInternetIcon
            notificationButtonDisabled: .blue3F4962, // notificationfeedIconInactive
            notificationButtonNotes: .blue00A7C4, // notificationfeedIconNotes
            notificationButtonNotesAndTasks: .whiteFFFFFF, // notificationfeedIconNotesAndOpenTasks
            newBookingButton: .whiteFFFFFF, // newBooking / walkIn
            newWalkinButton: .whiteFFFFFF, // newBooking / walkIn
            
            // MARK: TimelineView
            horizontalSeparator: .grayCCCCCC, // horizontalSeparatorColor
            verticalSeparator: .blue3F4962, // verticalSeparatorColor (full hours)
            verticalSubSeparator: .grayCCCCCC, // verticalSeparatorColor (quarter & half hour)
            timeIndicatorLine: .blue00A7C4, // timeFocusVerticalLineColor
            
            // MARK: LinkIcon
            linkIconPartiallyOccupiedTable: .green22CCAA, // linkedTableOccupiedFreeSeatsIcon
            linkIconFullTable: .blue00A7C4, // linkedTableFullyOccupiedIcon
            
            // MARK: OfflinePopover
            offlineViewBorder: .whiteFFFFFF // noInternetAlertBackgroundColor
        ),
        
        // MARK: -
        // MARK: // Text
        text_: Text(
            // MARK: // General
            default: .gray555555, // defaultTextColor
            inverted: .whiteFFFFFF, // darkBackgroundTextColor
            navigationBar: .whiteFFFFFF, // headerTextColor
            titleLabel: .blue3F4962, // headingTextColor
            descriptionLabel: .gray999999,
            valueLabel: .gray555555,
            placeholder: .grayCCCCCC, // inputHelpTextColor
            highlighted: .blue00A7C4, // today/highlightedTextColor
            
            // MARK: // Specific
            // MARK: MainMenuView
            mainMenuItem: .grayDDDDDD, // navigationBarTextColor
            mainMenuSelectedItem: .whiteFFFFFF, // selectedItemNavigationsBarTextColor
            
            // MARK: MainTitleView
            mainTitleView: .whiteFFFFFF, // arrows / time / date
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .whiteFFFFFF, // notificationBadgeTextColor
            notificationsViewSectionHeader: .gray555555, // notificationfeedHeadingColor
            noteCell: .blue018EA6, // notificationfeedNoteTextColor
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
        
        // MARK: -
        // MARK: // BookingStatus
        bookingStatus_: BookingStatus(
            unconfirmed: .yellowD7A43B, // Unconfirmed
            confirmed: .blue00A7C4, // Confirmed
            arrived: .green22CCAA, // Arrived
            seated: .yellowF8C150, // Seated
            finished: .gray999999, // Finished
            noShow: .blue3F4962, // No-Show
            cancelled: .redE62C4F // Cancelled
        )
    )
}
