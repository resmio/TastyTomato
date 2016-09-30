//
//  BookingStatusIcon.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/19/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
open class BookingStatusIcon: MetaImage {
    open static let Confirmed: BookingStatusIcon = BookingStatusIcon.suffixed_("confirmed")
    open static let Arrived: BookingStatusIcon = BookingStatusIcon.suffixed_("arrived")
    open static let Seated: BookingStatusIcon = BookingStatusIcon.suffixed_("seated")
    open static let Finished: BookingStatusIcon = BookingStatusIcon.suffixed_("finished")
    open static let NoShow: BookingStatusIcon = BookingStatusIcon.suffixed_("noshow")
    open static let Cancelled: BookingStatusIcon = BookingStatusIcon.imageNamed_("MiscIcon-x")
}
