//
//  Dark.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 07.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
@objc public extension ColorScheme {
    static let dark: ColorScheme = ColorScheme(
        name_: "Dark",
        
        // MARK: -
        // MARK: // Background
        background_: Background(
            // MARK: // General
            default: .blue293140,
            navigationBar: .blue1E2532, // headerBackgroundColor
            defaultPopover: .blue293140, // popoverBackgroundColor
            defaultSelected: .blue00A7C4, // selection / focus
            newBookingFlow: .blue293140, // walkIn / newBookingBackgroundColor
            filledButton: .blue00A7C4,
            filledButtonDimmed: .blueC0F6FF,
            createButton: .blue00A7C4, // createButton
            deleteButton: .redE62C4F, // deleteButton
            warningTextView: .yellowF8C150,
            
            // MARK: // Specific
            // MARK: LoginView
            login: .blue293140, // SignInBackgroundColor (background image +)
            
            // MARK: MainMenuView
            mainMenu: .blue1E2532, // navigationbarBackgroundColor
            mainMenuHeader: .blue293140, // navigationbarTopBackgroundColor
            mainMenuSelectedItem: .blue293140, // selectedItemNavigationbarBackgroundColor
            mainMenuSelectedItemBanner: .blue00A7C4, // selectedItemNavigationbarLeftBorderColor
            
            // MARK: SettingsMenu
            settingsMenu: .blue293140,
            settingsMenuSelectedItem: .blue1E2532, // selectedItemNavigationbarBackgroundColor (second hierarchy)
            settingsMenuSelectedItemBanner: .blue00A7C4, // selectedItemNavigationbarLeftBorderColor
            
            // MARK: BookingsView
            searchFieldContainer: .blue293140, // aroundSearchFieldBackgroundColor
            searchField: .blue333B4F, // searchFieldFillColor
            bookingStatusSectionHeader: .blue293140, // statusBookingListBackgroundColor
            bookingCell: .blue333B4F, // bookingsBookingListBackgroundColor
            
            // MARK: RoomsView
            roomsView: .blue293140, // roomAreaBackgroundColor
            
            // MARK: ChooseTablesView
            numOfSeatsInfoPerfect: .green22CCAA, // newBookingSeatsPerfect
            
            // MARK: TischView
            freeTable: .gray999999, // freeTable
            partiallyOccupiedTable: .green22CCAA, // occupiedTableWithFreeSeats
            fullTable: .blue00A7C4, // fullyOccupiedTableNoSeats
            blockedTableStripe: .gray555555, // blockedTable (stripes)
            chairColor: .gray999999, // Seats
            
            // MARK: TimelineView
            timelineView: .blue293140, // timelineBackgroundColor
            timeIndicatorLabel: .blue00A7C4, // timeFocusFillColor
            
            // MARK: SettingsView
            settingsView: .blue293140, // settingsBackgroundColor
            
            // MARK: CalendarView
            selectedDay: .blue00A7C4, // BackgroundFilled
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .redE62C4F, // notificationBadgeBackgroundColor
            notificationsView: .blue293140, // notificationfeedBackgroundColor
            notificationsViewSectionHeader: .blue333B4F, // notificationfeedheadingsBackgroundColor
            noteCell: .blueC0F6FF, // notificationfeedNotesBackgroundColor
            taskCellUnread: .yellowFFF2D8, // notificationsfeedNewOpenTasksBackgroundColor
            taskCellRead: .clear, // notificationsfeedReadOpenTasksBackgroundColor
            
            // MARK: OfflinePopover
            offlineView: .blue293140, // noInternetAlertBackgroundColor
            
            // MARK: TableInfoPopover
            tableInfoPopoverButton: .blue1E2532, // buttonInPopover (newBooking/ walkIn/ blocking)
            
            // MARK: SuccessHUD
            successHUD: .green22CCAA // successBackgroundColor
        ),
        
        // MARK: -
        // MARK: // Lines
        lines_: Lines(
            // MARK: // General
            separator: .blue1E2532, // separatorColor
            borderUnfocussed: .blue3F4962, // borderColor
            borderFocussed: .blue00A7C4, // focusBorderColor
            switchTint: .grayCCCCCC, // switchButtonOutline
            switchOnTint: .blue00A7C4, // switchButtonON
            stepperTint: .whiteFFFFFF, // minusPlusButton
            sliderTint: .blue00A7C4,
            segmentedControl: .blue00A7C4, // selectButton
            defaultIcon: .whiteFFFFFF, // iconsOnWhitebackground
            invertedIcon: .gray555555, // iconsOnDarkbackground
            contrastIcon: .whiteFFFFFF,
            highlighted: .blue00A7C4, // today/highlightedTextColor
            warning: .yellowF8C150,
            
            // MARK: // Specific
            // MARK: MainTitleView
            mainTitleViewButtonBorder: .blue3F4962, // buttonBorderColor (all, except hamburger)
            hamburgerIcon: .whiteFFFFFF, // hamburgerIcon
            mainTitleViewArrowIcon: .whiteFFFFFF, // arrows / time / date
            nowButtonEnabled: .whiteFFFFFF, // nowButtonActiveBorderColor
            nowButtonDisabled: .blue333B4F, // nowButtonBorderInactiveColor
            offlineIcon: .redE62C4F, // noInternetIcon
            notificationButtonDisabled: .blue333B4F, // notificationfeedIconInactive
            notificationButtonNotes: .blue00A7C4, // notificationfeedIconNotes
            notificationButtonNotesAndTasks: .whiteFFFFFF, // notificationfeedIconNotesAndOpenTasks
            newBookingButton: .whiteFFFFFF, // newBooking / walkIn
            newWalkinButton: .whiteFFFFFF, // newBooking / walkIn
            
            // MARK: MainMenuView
            mainMenuHeaderSeparator: .blue1E2532,
            
            // MARK: TimelineView
            horizontalSeparator: .blue1E2532, // horizontalSeparatorColor
            verticalSeparator: .blue3F4962, // verticalSeparatorColor (full hours)
            verticalSubSeparator: .blue1E2532, // verticalSeparatorColor (quarter & half hour)
            timeIndicatorLine: .blue00A7C4, // timeFocusVerticalLineColor
            
            // MARK: LinkIcon
            linkIconPartiallyOccupiedTable: .green22CCAA, // linkedTableOccupiedFreeSeatsIcon
            linkIconFullTable: .blue00A7C4, // linkedTableFullyOccupiedIcon
            
            // MARK: OfflinePopover
            offlineViewBorder: .redE62C4F // noInternetAlertBackgroundColor
        ),
        
        // MARK: -
        // MARK: // Text
        text_: Text(
            // MARK: // General
            default: .whiteFFFFFF, // darkBackgroundTextColor
            inverted: .gray555555, // lightBackgroundTextColor / TextColor
            navigationBar: .whiteFFFFFF, // headerTextColor
            titleLabel: .whiteFFFFFF, // headingTextColor
            descriptionLabel: .grayDDDDDD,
            valueLabel: .whiteFFFFFF,
            placeholder: .blue3F4962, // inputHelpTextColor
            highlighted: .blue00A7C4, // today/highlightedTextColor
            filledButton: .whiteFFFFFF,
            warningTextView: .whiteFFFFFF,
            
            // MARK: // Specific
            // MARK: MainMenuView
            mainMenuHeader: .whiteFFFFFF,
            mainMenuItem: .grayDDDDDD, // navigationBarTextColor
            mainMenuSelectedItem: .whiteFFFFFF, // selectedItemNavigationsBarTextColor
            
            // MARK: SettingsMenuView
            settingsMenuItem: .grayDDDDDD,
            settingsMenuSelectedItem: .whiteFFFFFF,
            
            // MARK: MainTitleView
            mainTitleView: .whiteFFFFFF, // arrows / time / date
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .whiteFFFFFF, // notificationBadgeTextColor
            notificationsViewSectionHeader: .whiteFFFFFF, // notificationfeedHeadingColor
            noteCell: .blue018EA6, // notificationfeedNoteTextColor
            taskCellUnread: .yellowD7A43B, // notificationfeedNewOpenTasksTextColor
            taskCellRead: .whiteFFFFFF, // notificationsfeedReadOpenTasksBackgroundColor
            
            // MARK: TischView
            partiallyOccupiedTable: .green22CCAA, // occupiedTableWithFreeSeats
            fullTable: .blue00A7C4, // occupiedTableNoSeats
            blocking: .redE62C4F, // blocking
            
            // MARK: CalendarView
            monthHeading: .whiteFFFFFF, // monthHeadingTextColor
            weekdayName: .whiteF7F7F7, // weekdayLabelsTextColor
            pastDay: .grayCCCCCC, // pastDaysTextColor
            today: .blue00A7C4, // todayTextColor
            selectedDay: .whiteFFFFFF, // selectedDayTextColor
            dateInCurrentMonth: .whiteFFFFFF, // currentMonthDaysTextColor
            dateInOtherMonth: .grayDDDDDD, // nextMonthDatesTextColor
            
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
