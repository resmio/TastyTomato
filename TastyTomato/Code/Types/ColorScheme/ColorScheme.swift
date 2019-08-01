//
//  ColorScheme.swift
//  TastyTomato
//
//  Created by Jan Nash (resmio) on 01.08.19.
//  Copyright © 2019 resmio. All rights reserved.
//

import UIKit


// MARK: // Public
// MARK: Class Declaration
@objc public class ColorScheme: NSObject {
    // Current ColorScheme
    public static var current: ColorScheme = .light
    
    // Predefined ColorSchemes
    public static let light: ColorScheme = ColorScheme()
    public static let dark: ColorScheme = ColorScheme()
}
