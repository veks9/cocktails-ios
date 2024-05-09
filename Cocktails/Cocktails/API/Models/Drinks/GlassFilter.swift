//
//  GlassFilter.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation

extension Model {
    struct GlassFilter: Decodable {
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case name = "strGlass"
        }
    }
}
