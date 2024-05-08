//
//  Assets.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI
import UIKit

enum Assets: String {
    case alcoholic
    case back
    case category
    case cocktail
    case filter
    case glass
    case radioButton = "radio_button"
    case radioButtonSelected = "radio_button_selected"
    case search
    case searchCancel = "search_cancel"

    var image: Image? {
        Image(rawValue)
    }
    
    var uiImage: UIImage? {
        UIImage(named: rawValue)
    }
}
