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
    public static var Confirmed: BookingStatusIcon {
        return BookingStatusIcon.suffixed_("confirmed")
    }
    
    public static var Arrived: BookingStatusIcon {
        return BookingStatusIcon.suffixed_("arrived")
    }
    
    public static var Seated: BookingStatusIcon {
        return BookingStatusIcon.suffixed_("seated")
    }
    
    public static var Finished: BookingStatusIcon {
        return BookingStatusIcon.suffixed_("finished")
    }
    
    public static var NoShow: BookingStatusIcon {
        return BookingStatusIcon.suffixed_("noshow")
    }
    
    public static var Cancelled: BookingStatusIcon {
        return BookingStatusIcon.imageNamed_("MiscIcon-x")
    }
}
