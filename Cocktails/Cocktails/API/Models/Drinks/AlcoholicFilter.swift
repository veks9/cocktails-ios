//
//  AlcoholicFilter.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation

extension Model {
    struct AlcoholicFilter: Decodable {
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case name = "strAlcoholic"
        }
    }
}
