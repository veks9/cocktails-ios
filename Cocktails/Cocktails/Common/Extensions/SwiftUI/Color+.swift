//
//  Color+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

extension Color {
    /// r: 128 g: 160 b: 248
    static var appPrimary: Color {
        Color(UIColor(red: 128.0 / 255.0, green: 160.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0))
    }
    
    /// r: 242 g: 242 b: 242
    static var lightGray: Color {
        Color(UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0))
    }
    
    /// r: 247 g: 247 b: 255
    static var backgroundPrimary: Color {
        Color(UIColor(red: 244.0 / 255.0, green: 247.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0))
    }
    
    /// r: 163 g: 171 b: 195
    static var appDisabled: Color {
        Color(UIColor(red: 163.0 / 255.0, green: 171.0 / 255.0, blue: 195.0 / 255.0, alpha: 1.0))
    }
}
