//
//  MiscIcon.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/19/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public class MiscIcon: MetaImage {
    public static var Add: MiscIcon {
        return MiscIcon.suffixed_("add")
    }
    
    public static var BlockNote: MiscIcon {
        return MiscIcon.suffixed_("block-note")
    }
    
    public static var Checkmark: MiscIcon {
        return MiscIcon.suffixed_("checkmark")
    }
    
    public static var Location: MiscIcon {
        return MiscIcon.suffixed_("location")
    }
    
    public static var Offline: MiscIcon {
        return MiscIcon.suffixed_("offline")
    }
    
    public static var Persons: MiscIcon {
        return MiscIcon.suffixed_("persons")
    }
    
    public static var WalkIn: MiscIcon {
        return MiscIcon.suffixed_("walk-in")
    }
    
    public static var Warning: MiscIcon {
        return MiscIcon.suffixed_("warning")
    }
    
    public static var X: MiscIcon {
        return MiscIcon.suffixed_("x")
    }
}
