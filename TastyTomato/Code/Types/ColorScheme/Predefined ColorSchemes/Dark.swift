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
        name_: NSL_("Dark"),
        
        // MARK: -
        // MARK: // Background
        background_: Background(
            // MARK: // General
            default: .blue293140,
            navigationBar: .blue1E2532,
            defaultPopover: .blue293140,
            defaultSelected: .blue00A7C4,
            addBookingFlow: .blue293140,
            filledButton: .blue00A7C4,
            filledButtonDimmed: .blueC0F6FF,
            createButton: .green22CCAA,
            deleteButton: .redE62C4F,
            warning: .yellowF8C150,
            criticalWarning: .redE62C4F,
            
            // MARK: // Specific
            // MARK: BottomRightButton
            bottomRightButtonNormal: .blue333B4F,
            bottomRightButtonSelected: .yellowD7A43B,
    
            // MARK: MainTitleView
            nowButtonEnabled: .blue3F4962,
            
            // MARK: LoginView
            login: .blue293140,
            
            // MARK: MainMenuView
            mainMenu: .blue1E2532,
            mainMenuHeader: .blue293140,
            mainMenuSelectedItem: .blue293140,
            mainMenuSelectedItemBanner: .blue00A7C4,
            
            // MARK: SettingsMenu
            settingsMenu: .blue293140,
            settingsMenuSelectedItem: .blue1E2532,
            settingsMenuSelectedItemBanner: .blue00A7C4,
            
            // MARK: BookingsView
            searchFieldContainer: .blue293140,
            searchField: .blue333B4F,
            bookingStatusSectionHeader: .blue293140,
            bookingCell: .blue333B4F,
            
            // MARK: RoomsView
            roomsView: .blue293140,
            
            // MARK: ChooseTablesView
            numOfSeatsInfoPerfect: .green22CCAA,
            
            // MARK: TischView
            freeTable: .gray999999,
            partiallyOccupiedTable: .green22CCAA,
            fullTable: .blue00A7C4,
            blockedTableStripe: .gray555555,
            chairColor: .gray999999,
            
            // MARK: TimelineView
            timelineView: .blue293140,
            timeIndicatorLabel: .blue00A7C4,
            timelineNumOfSeatsLabel: .blue1E2532,
            
            // MARK: OrderCell
            cardView: .blue1E2532,
            newBanner: .yellowD7A43B,
            remainingMinutesBannerRemaining: .blue018EA6,
            remainingMinutesBannerOverdue: .redE62C4F,
            
            // MARK: OrderDetailView
            orderDetailViewBackground: .blue1E2532,
            orderNote: .blue018EA6,
            
            // MARK: SettingsView
            settingsView: .blue293140,
            
            // MARK: CalendarView
            selectedDay: .blue00A7C4,
            
            // MARK: NotificationsPopover
            notificationButtonBadge: .redE62C4F,
            notificationsView: .blue293140,
            notificationsViewSectionHeader: .blue333B4F,
            noteCell: .blueC0F6FF,
            taskCellUnread: .yellowFFF2D8,
            taskCellRead: .clear,
            
            // MARK: OfflinePopover
            offlineView: .blue293140,
            
            // MARK: TableInfoPopover
            tableInfoPopoverButton: .blue1E2532,
            
            // MARK: SuccessHUD
            successHUD: .green22CCAA
        ),
        
        // MARK: -
        // MARK: // Lines
        lines_: Lines(
            // MARK: // General
            separator: .blue1E2532,
            borderUnfocussed: .blue3F4962,
            borderFocussed: .blue00A7C4,
            switchTint: .grayCCCCCC,
            switchOnTint: .blue00A7C4,
            stepperTint: .whiteFFFFFF,
            sliderTint: .blue00A7C4,
            segmentedControl: .blue00A7C4,
            defaultIcon: .whiteFFFFFF,
            invertedIcon: .gray555555,
            contrastIcon: .whiteFFFFFF,
            highlighted: .blue00A7C4,
            warning: .yellowF8C150,
            criticalWarning: .redE62C4F,
            navBarButtonDisabled: .blue333B4F,
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
            notificationButtonDisabled: .blue333B4F,
            notificationButtonNotes: .blue00A7C4,
            notificationButtonNotesAndTasks: .whiteFFFFFF,
            newWaitlistElementButton: .whiteFFFFFF,
            newBookingButton: .whiteFFFFFF,
            newWalkinButton: .whiteFFFFFF,
            
            // MARK: MainMenuView
            mainMenuHeaderSeparator: .blue1E2532,
            
            // MARK: TimelineView
            horizontalSeparator: .blue1E2532,
            verticalSeparator: .blue3F4962,
            verticalSubSeparator: .blue1E2532,
            timeIndicatorLine: .blue00A7C4,
            
            // MARK: LinkIcon
            linkIconPartiallyOccupiedTable: .green22CCAA,
            linkIconFullTable: .blue00A7C4,
            
            // MARK: OfflinePopover
            offlineViewBorder: .redE62C4F
        ),
        
        // MARK: -
        // MARK: // Text
        text_: Text(
            // MARK: // General
            default: .whiteFFFFFF,
            inverted: .gray555555,
            navigationBar: .whiteFFFFFF,
            titleLabel: .whiteFFFFFF,
            descriptionLabel: .grayDDDDDD,
            valueLabel: .whiteFFFFFF,
            linkLabel: .blue00A7C4,
            placeholder: .blue3F4962,
            highlighted: .blue00A7C4,
            filledButton: .whiteFFFFFF,
            warningTextView: .whiteFFFFFF,
            warning: .redE62C4F,
            
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
            notificationsViewSectionHeader: .whiteFFFFFF,
            noteCell: .blue018EA6,
            taskCellUnread: .yellowD7A43B,
            taskCellRead: .whiteFFFFFF,
            
            // MARK: TischView
            partiallyOccupiedTable: .green22CCAA,
            fullTable: .blue00A7C4,
            blocking: .redE62C4F,
            
            // MARK: CalendarView
            monthHeading: .whiteFFFFFF,
            weekdayName: .whiteF7F7F7,
            pastDay: .grayCCCCCC,
            today: .blue00A7C4,
            selectedDay: .whiteFFFFFF,
            dateInCurrentMonth: .whiteFFFFFF,
            dateInOtherMonth: .grayCCCCCC,
            dateInPast: .blue3F4962,
            
            // MARK: TimelineView
            timeIndicatorLabel: .whiteFFFFFF,
            
            // MARK: OrderDetailView
            orderNote: .whiteFFFFFF,
            
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
        ),
        
        // MARK: -
        // MARK: // OrderStatus
        orderStatus_: OrderStatus( // FIXME:
            new: .yellowD7A43B,
            inProgress: .blue00A7C4,
            completed: .gray999999,
            cancelled: .redE62C4F
        )
    )
}
