//
//  ContentType.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

enum ContentType {
    case applicationJson

    var httpHeaderText: String {
        switch self {
        case .applicationJson:
            return "application/json"
        }
    }
}
