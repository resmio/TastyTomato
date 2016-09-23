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

    // MARK: Resource-Bundles
    static let LocalizationBundle: NSBundle = NSBundle(path: _localizationBundlePath)!
    
    // MARK: // Private
    // MARK: Resource-Bundle Paths
    private static let _localizationBundlePath: String = TastyTomatoBundle.pathForResource("TTLocalizations", ofType: "bundle")!
}
