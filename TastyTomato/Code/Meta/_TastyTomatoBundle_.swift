//
//  TastyTomatoBundle_.swift
//  TastyTomato
//
//  Created by Jan Nash on 7/22/16.
//  Copyright © 2016 resmio. All rights reserved.
//

import Foundation


// MARK: // Internal
class BundleHelper_ {
    // MARK: Framework-Bundle
    static let TastyTomatoBundle: NSBundle = NSBundle(forClass: BundleHelper_.self)

    // MARK: Localization-Bundle
    static let LocalizationBundle: NSBundle = NSBundle(path: _localizationBundlePath)!

    // MARK: // Private
    // MARK: Localization-Bundle Path
    private static let _localizationBundlePath: String = TastyTomatoBundle.pathForResource("Localizations", ofType: "bundle")!
}
