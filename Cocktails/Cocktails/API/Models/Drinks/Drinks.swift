//
//  Drinks.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

extension Model {
    struct Drinks: Codable, Hashable {
        let drinks: [Model.Drink]
    }
}
