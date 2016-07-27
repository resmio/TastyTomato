//
//  BookingStatusIcon.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/19/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public class BookingStatusIcon: MetaImage {
    public static let Confirmed: BookingStatusIcon = BookingStatusIcon.suffixed_("confirmed")
    public static let Arrived: BookingStatusIcon = BookingStatusIcon.suffixed_("arrived")
    public static let Seated: BookingStatusIcon = BookingStatusIcon.suffixed_("seated")
    public static let Finished: BookingStatusIcon = BookingStatusIcon.suffixed_("finished")
    public static let NoShow: BookingStatusIcon = BookingStatusIcon.suffixed_("noshow")
    public static let Cancelled: BookingStatusIcon = BookingStatusIcon.imageNamed_("MiscIcon-x")
}
