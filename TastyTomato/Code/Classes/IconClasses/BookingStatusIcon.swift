//
//  BookingStatusIcon.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/19/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
public class BookingStatusIcon: UIImage {
    public static let Confirmed: BookingStatusIcon = BookingStatusIcon.named_("confirmed")
    public static let Arrived: BookingStatusIcon = BookingStatusIcon.named_("arrived")
    public static let Seated: BookingStatusIcon = BookingStatusIcon.named_("seated")
    public static let Finished: BookingStatusIcon = BookingStatusIcon.named_("finished")
    public static let NoShow: BookingStatusIcon = BookingStatusIcon.named_("noshow")
    public static let Cancelled: BookingStatusIcon = BookingStatusIcon.named_("cancelled")
}
