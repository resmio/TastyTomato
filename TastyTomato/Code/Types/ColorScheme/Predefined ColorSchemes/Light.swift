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
        name_: NSL_("Light"),
        
        // MARK: -
        // MARK: // Background
        background_: Background(
            // MARK: // General
            default: .whiteFFFFFF,
            navigationBar: .blue333B4F,
            defaultPopover: .whiteFFFFFF,
            defaultSelected: .blue00A7C4,
            addBookingFlow: .whiteFFFFFF,
            filledButton: .blue00A7C4,
            filledButtonDimmed: .blueC0F6FF,
            createButton: .blue00A7C4,
            deleteButton: .redE62C4F,
            warning: .yellowF8C150,
            criticalWarning: .redE62C4F,
            
            // MARK: // Specific
            // MARK: MainTitleView
            nowButtonEnabled: .blue3F4962,
            
            // MARK: LoginView
            login: .whiteFFFFFF,
            
            // MARK: MainMenuView
            mainMenu: .blue333B4F,
            mainMenuHeader: .blue293140,
            mainMenuSelectedItem: .blue293140,
            mainMenuSelectedItemBanner: .blue00A7C4,
            
            // MARK: SettingsMenu
            settingsMenu: .blue293140,
            settingsMenuSelectedItem: .blue1E2532,
            settingsMenuSelectedItemBanner: .blue00A7C4,
            
            // MARK: BookingsView
            searchFieldContainer: .grayCCCCCC,
            searchField: .whiteF7F7F7,
            bookingStatusSectionHeader: .whiteFFFFFF,
            bookingCell: .whiteF7F7F7,
            
            // MARK: RoomsView
            roomsView: .whiteFFFFFF,
            
            // MARK: ChooseTablesView
            numOfSeatsInfoPerfect: .green22CCAA,
            
            // MARK: TischView
            freeTable: .gray999999,
            partiallyOccupiedTable: .green22CCAA,
            fullTable: .blue00A7C4,
            blockedTableStripe: .gray555555,
            chairColor: .gray555555,
            
            // MARK: TimelineView
            timelineView: .whiteFFFFFF,
            timeIndicatorLabel: .blue00A7C4,
            timelineNumOfSeatsLabel: .grayCCCCCC,
            
            // MARK: SettingsView
            settingsView: .whiteFFFFFF,
            
            // MARK: CalendarView
            selectedDay: .blue00A7C4,
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .redE62C4F,
            notificationsView: .whiteFFFFFF,
            notificationsViewSectionHeader: .whiteF7F7F7,
            noteCell: .blueC0F6FF,
            taskCellUnread: .yellowFFF2D8,
            taskCellRead: .clear,
            
            // MARK: OfflinePopover
            offlineView: .whiteFFFFFF,
            
            // MARK: TableInfoPopover
            tableInfoPopoverButton: .blue333B4F,
            
            // MARK: SuccessHUD
            successHUD: .green22CCAA
        ),
        
        // MARK: -
        // MARK: // Lines
        lines_: Lines(
            // MARK: // General
            separator: .grayCCCCCC,
            borderUnfocussed: .grayCCCCCC,
            borderFocussed: .blue00A7C4,
            switchTint: .grayCCCCCC,
            switchOnTint: .blue00A7C4,
            stepperTint: .gray555555,
            sliderTint: .blue00A7C4,
            segmentedControl: .blue00A7C4,
            defaultIcon: .gray555555,
            invertedIcon: .whiteFFFFFF,
            contrastIcon: .gray555555,
            highlighted: .blue00A7C4,
            warning: .yellowF8C150,
            criticalWarning: .redE62C4F,
            navBarButtonDisabled: .blue3F4962,
            filledNextButtonImage: .whiteFFFFFF,
            
            // MARK: // Specific
            // MARK: MainTitleView
            mainTitleViewButtonBorder: .blue3F4962,
            hamburgerIcon: .whiteFFFFFF,
            mainTitleViewArrowIcon: .whiteFFFFFF,
            nowButtonEnabled: .whiteFFFFFF,
            timeshiftsButtonInactive: .whiteFFFFFF,
            timeshiftsButtonActive: .blue00A7C4,
            offlineIcon: .redE62C4F,
            notificationButtonDisabled: .blue3F4962,
            notificationButtonNotes: .blue00A7C4,
            notificationButtonNotesAndTasks: .whiteFFFFFF,
            newBookingButton: .whiteFFFFFF,
            newWalkinButton: .whiteFFFFFF,
            
            // MARK: MainMenuView
            mainMenuHeaderSeparator: .blue333B4F,
            
            // MARK: TimelineView
            horizontalSeparator: .grayCCCCCC,
            verticalSeparator: .blue3F4962,
            verticalSubSeparator: .grayCCCCCC,
            timeIndicatorLine: .blue00A7C4,
            
            // MARK: LinkIcon
            linkIconPartiallyOccupiedTable: .green22CCAA,
            linkIconFullTable: .blue00A7C4,
            
            // MARK: OfflinePopover
            offlineViewBorder: .whiteFFFFFF
        ),
        
        // MARK: -
        // MARK: // Text
        text_: Text(
            // MARK: // General
            default: .gray555555,
            inverted: .whiteFFFFFF,
            navigationBar: .whiteFFFFFF,
            titleLabel: .blue3F4962,
            descriptionLabel: .gray999999,
            valueLabel: .gray555555,
            placeholder: .grayCCCCCC,
            highlighted: .blue00A7C4,
            filledButton: .whiteFFFFFF,
            warningTextView: .whiteFFFFFF,
            
            // MARK: // Specific
            // MARK: MainMenuView
            mainMenuHeader: .whiteFFFFFF,
            mainMenuItem: .grayDDDDDD,
            mainMenuSelectedItem: .whiteFFFFFF,
            
            // MARK: SettingsMenuView
            settingsMenuItem: .grayDDDDDD,
            settingsMenuSelectedItem: .whiteFFFFFF,
            
            // MARK: MainTitleView
            mainTitleView: .whiteFFFFFF,
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .whiteFFFFFF,
            notificationsViewSectionHeader: .gray555555,
            noteCell: .blue018EA6,
            taskCellUnread: .yellowD7A43B,
            taskCellRead: .gray555555,
            
            // MARK: TischView
            partiallyOccupiedTable: .green22CCAA,
            fullTable: .blue00A7C4,
            blocking: .redE62C4F,
            
            // MARK: CalendarView
            monthHeading: .gray555555,
            weekdayName: .gray555555,
            pastDay: .grayCCCCCC,
            today: .blue00A7C4,
            selectedDay: .whiteFFFFFF,
            dateInCurrentMonth: .gray555555,
            dateInOtherMonth: .gray999999,
            dateInPast: .grayCCCCCC,
            
            // MARK: TimelineView
            timeIndicatorLabel: .whiteFFFFFF,
            
            // MARK: TextButtons
            saveButton: .green22CCAA,
            cancelButton: .redE62C4F,
            nextButton: .whiteFFFFFF,
            backButton: .whiteFFFFFF,
            doneButton: .green22CCAA,
            newButton: .blue00A7C4,
            editButton: .blue00A7C4,
            deleteButton: .redE62C4F
        ),
        
        // MARK: -
        // MARK: // BookingStatus
        bookingStatus_: BookingStatus(
            unconfirmed: .yellowD7A43B,
            confirmed: .blue00A7C4,
            arrived: .green22CCAA,
            seated: .yellowF8C150,
            finished: .gray999999,
            noShow: .blue3F4962,
            cancelled: .redE62C4F
        )
    )
}
