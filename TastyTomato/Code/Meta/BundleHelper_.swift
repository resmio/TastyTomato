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
    static let TastyTomatoBundle: Bundle = Bundle(for: BundleHelper_.self)

    // MARK: Resource-Bundles
    static let LocalizationBundle: Bundle = Bundle(path: _localizationBundlePath)!
    
    // MARK: // Private
    // MARK: Resource-Bundle Paths
    fileprivate static let _localizationBundlePath: String = TastyTomatoBundle.path(forResource: "TTLocalizations", ofType: "bundle")!
}
