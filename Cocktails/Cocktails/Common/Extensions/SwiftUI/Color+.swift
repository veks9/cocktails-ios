//
//  Color+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

extension Color {
    /// r: 100 g: 151 b: 250
    static var appPrimary: Color {
        Color(UIColor(red: 100.0 / 255.0, green: 151.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0))
    }
    
    /// r: 242 g: 242 b: 242
    static var lightGray: Color {
        Color(UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0))
    }
    
    /// r: 247 g: 247 b: 255
    static var backgroundPrimary: Color {
        Color(UIColor(red: 244.0 / 255.0, green: 247.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0))
    }
}
