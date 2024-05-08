//
//  Optional+.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
}
