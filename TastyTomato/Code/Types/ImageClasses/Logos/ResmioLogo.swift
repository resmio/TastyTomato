//
//  ResmioLogo.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/22/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
public class ResmioLogo: MetaImage {
    public static var DefaultBlackText: ResmioLogo {
        return ResmioLogo.suffixed_("default-black-text")
    }
    
    public static var DefaultWhiteText: ResmioLogo {
        return ResmioLogo.suffixed_("default-white-text")
    }
    
    public static var BetaBlackText: ResmioLogo {
        return ResmioLogo.suffixed_("beta-black-text")
    }
    
    public static var BetaWhiteText: ResmioLogo {
        return ResmioLogo.suffixed_("beta-white-text")
    }
}
