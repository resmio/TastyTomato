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
            navigationBar: .blue1E2532, // headerBackgroundColor
            defaultPopover: .blue293140, // popoverBackgroundColor
            defaultSelected: .blue00A7C4, // selection / focus
            newBookingFlow: .blue293140, // walkIn / newBookingBackgroundColor
            selectButton: .blue00A7C4, // selectButton
            createButton: .blue00A7C4, // createButton
            deleteButton: .redE62C4F, // deleteButton
            switchOn: .blue00A7C4, // switchButtonON
            switchOff: .whiteF7F7F7, // switchButtonOFF
            
            // MARK: // Specific
            // MARK: LoginView
            // FIXME: what does "(background image +)" mean?
            login: .blue293140, // SignInBackgroundColor (background image +)
            signInButton: .blue00A7C4, // SignInButton
            
            // MARK: MainMenuView
            mainMenu: .blue1E2532, // navigationbarBackgroundColor
            mainMenuHeader: .blue293140, // navigationbarTopBackgroundColor
            mainMenuSelectedItem: .blue293140, // selectedItemNavigationbarBackgroundColor
            mainMenuSelectedSubItem: .blue1E2532, // selectedItemNavigationbarBackgroundColor (second hierarchy)
            mainMenuSelectedItemBanner: .blue00A7C4, // selectedItemNavigationbarLeftBorderColor
            
            // MARK: BookingsView
            searchFieldContainer: .blue293140, // aroundSearchFieldBackgroundColor
            searchField: .blue333B4F, // searchFieldFillColor
            bookingStatusSectionHeader: .blue293140, // statusBookingListBackgroundColor
            bookingCell: .blue333B4F, // bookingsBookingListBackgroundColor
            
            // MARK: RoomsView
            // FIXME: roomWithoutFloorBackgroundColor and diningAreasBackgroundColor have been left out,
            // rooms without floor simply have a clear background.
            roomsView: .blue293140, // roomAreaBackgroundColor
            
            // MARK: ChooseTablesView
            numOfSeatsInfoPerfect: .green22CCAA, // newBookingSeatsPerfect
            numOfSeatsInfoWarning: .yellowF8C150, // newBookingSeatsAreNeeded /Overlapping
            overlapWarning: .yellowF8C150, // newBookingSeatsAreNeeded /Overlapping
            
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
            // FIXME: Alpha 0.2?
            noteCell: .blue00A7C4, // notificationfeedNotesBackgroundColor
            // FIXME: Alpha 0.2?
            taskCellUnread: .yellowF8C150, // notificationsfeedNewOpenTasksBackgroundColor
            taskCellRead: .whiteFFFFFF, // notificationsfeedReadOpenTasksBackgroundColor
            
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
            borderUnfocussed: .blue3E4862, // borderColor
            borderFocussed: .blue00A7C4, // focusBorderColor
            switchBorder: .grayCCCCCC, // switchButtonOutline
            stepperTint: .whiteFFFFFF, // minusPlusButton
            segmentedControl: .blue00A7C4, // selectButton
            iconOnLightBackground: .gray555555, // iconsOnWhitebackground
            iconOnDarkBackground: .whiteFFFFFF, // iconsOnDarkbackground
            
            // MARK: // Specific
            // MARK: MainTitleView
            buttonBorder: .blue3E4862, // buttonBorderColor (all, except hamburger)
            hamburgerIcon: .whiteFFFFFF, // hamburgerIcon
            arrowIcon: .whiteFFFFFF, // arrows / time / date
            nowButtonEnabled: .whiteFFFFFF, // nowButtonActiveBorderColor
            nowButtonDisabled: .blue333B4F, // nowButtonBorderInactiveColor
            offlineIcon: .redE62C4F, // noInternetIcon
            notificationButtonDisabled: .blue333B4F, // notificationfeedIconInactive
            notificationButtonNotes: .blue00A7C4, // notificationfeedIconNotes
            notificationButtonNotesAndTasks: .whiteFFFFFF, // notificationfeedIconNotesAndOpenTasks
            newBookingButton: .whiteFFFFFF, // newBooking / walkIn
            newWalkinButton: .whiteFFFFFF, // newBooking / walkIn
            
            // MARK: TimelineView
            horizontalSeparator: .blue1E2532, // horizontalSeparatorColor
            verticalSeparator: .blue3E4862, // verticalSeparatorColor (full hours)
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
            default: .grayDDDDDD, // defaultTextColor
            onDarkBackground: .whiteFFFFFF, // darkBackgroundTextColor
            // FIXME: what does the TextColor mean: lightBackgroundTextColor / TextColor
            onLightBackground: .gray555555, // lightBackgroundTextColor / TextColor
            navigationBar: .whiteFFFFFF, // headerTextColor
            titleLabel: .whiteFFFFFF, // headingTextColor
            // FIXME: what is: public let inputHelp: UIColor
            // FIXME: what is: public let today/highlighted: UIColor
            
            // MARK: // Specific
            // MARK: MainMenuView
            mainMenuItem: .grayDDDDDD, // navigationBarTextColor
            mainMenuSelectedItem: .whiteFFFFFF, // selectedItemNavigationsBarTextColor
            
            // MARK: MainTitleView
            mainTitleView: .whiteFFFFFF, // arrows / time / date
            // FIXME: I've left out nowButtonActive and nowButtonInactive
            // since they are in both color schemes similar to the
            // border colors of the enabled/disabled states
            
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
            noShow: .blue3E4862, // No-Show
            cancelled: .redE62C4F // Cancelled
        )
    )
}
