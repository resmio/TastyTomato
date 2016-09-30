//
//  ResmioLogo.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/22/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Public
open class ResmioLogo: MetaImage {
    open static let DefaultBlackText: ResmioLogo = ResmioLogo.suffixed_("default-black-text")
    open static let DefaultWhiteText: ResmioLogo = ResmioLogo.suffixed_("default-white-text")
    open static let BetaBlackText: ResmioLogo = ResmioLogo.suffixed_("beta-black-text")
    open static let BetaWhiteText: ResmioLogo = ResmioLogo.suffixed_("beta-white-text")
}
