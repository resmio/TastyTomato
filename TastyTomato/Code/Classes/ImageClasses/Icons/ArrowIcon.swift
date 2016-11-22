//
//  ArrowIcon.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/19/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
public class ArrowIcon: MetaImage {
    public static var Up: ArrowIcon {
        return ArrowIcon.suffixed_("up")
    }
    
    public static var Down: ArrowIcon {
        return ArrowIcon.suffixed_("down")
    }
    
    public static var Left: ArrowIcon {
        return ArrowIcon.suffixed_("left")
    }
    
    public static var Right: ArrowIcon {
        return ArrowIcon.suffixed_("right")
    }
}
