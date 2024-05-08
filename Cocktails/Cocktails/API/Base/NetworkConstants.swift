//
//  NetworkConstants.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

struct NetworkConstants {
    static var baseURLString: String {
        "https://www.thecocktaildb.com/api/json/v1/1"
    }
    
    static let baseURL = URL(string: baseURLString)!
}
