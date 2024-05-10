//
//  Endpoint.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

enum Endpoint {
    case search
    case details
    case random
    case list
    case filter

    var path: String {
        NetworkConstants.baseURLString + _path
    }

    private var _path: String {
        switch self {
        case .search:
            return "/search.php"
        case .details:
            return "/lookup.php"
        case .random:
            return "/random.php"
        case .list:
            return "/lista.php"
        case .filter:
            return "/filter.php"
        }
    }
}
