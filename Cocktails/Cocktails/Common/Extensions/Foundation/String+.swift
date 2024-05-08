//
//  String+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import SwiftUI

extension String {
    func toAttributedString(highlightedText: String, font: Font) -> AttributedString {
        var attributedString = AttributedString(self)
        if let range = attributedString.range(of: highlightedText) {
            attributedString[range].font = font
        }
        return attributedString
    }
}
