//
//  Drinks.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

extension Model {
    struct Response<T: Decodable>: Decodable {
        let data: T?
        
        enum CodingKeys: String, CodingKey {
            case data = "drinks"
        }
    }
}

