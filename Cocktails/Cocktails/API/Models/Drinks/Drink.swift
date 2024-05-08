//
//  Drink.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

extension Model {
    struct Drink: Decodable, Hashable {
        let id: String
        let name: String
        let category: String?
        let alcoholic: String?
        let glass: String?
        let instructions: String?
        let thumbnailUrl: URL?
        private let ingredient1: String?
        private let ingredient2: String?
        private let ingredient3: String?
        private let ingredient4: String?
        private let ingredient5: String?
        private let ingredient6: String?
        private let ingredient7: String?
        private let ingredient8: String?
        private let ingredient9: String?
        private let ingredient10: String?
        private let ingredient11: String?
        private let ingredient12: String?
        private let ingredient13: String?
        private let ingredient14: String?
        private let ingredient15: String?
        private let measure1: String?
        private let measure2: String?
        private let measure3: String?
        private let measure4: String?
        private let measure5: String?
        private let measure6: String?
        private let measure7: String?
        private let measure8: String?
        private let measure9: String?
        private let measure10: String?
        private let measure11: String?
        private let measure12: String?
        private let measure13: String?
        private let measure14: String?
        private let measure15: String?
        let dateModified: Date?
        
        enum CodingKeys: String, CodingKey {
            case id = "idDrink"
            case name = "strDrink"
            case category = "strCategory"
            case alcoholic = "strAlcoholic"
            case glass = "strGlass"
            case instructions = "strInstructions"
            case thumbnailUrl = "strDrinkThumb"
            case ingredient1 = "strIngredient1"
            case ingredient2 = "strIngredient2"
            case ingredient3 = "strIngredient3"
            case ingredient4 = "strIngredient4"
            case ingredient5 = "strIngredient5"
            case ingredient6 = "strIngredient6"
            case ingredient7 = "strIngredient7"
            case ingredient8 = "strIngredient8"
            case ingredient9 = "strIngredient9"
            case ingredient10 = "strIngredient10"
            case ingredient11 = "strIngredient11"
            case ingredient12 = "strIngredient12"
            case ingredient13 = "strIngredient13"
            case ingredient14 = "strIngredient14"
            case ingredient15 = "strIngredient15"
            case measure1 = "strMeasure1"
            case measure2 = "strMeasure2"
            case measure3 = "strMeasure3"
            case measure4 = "strMeasure4"
            case measure5 = "strMeasure5"
            case measure6 = "strMeasure6"
            case measure7 = "strMeasure7"
            case measure8 = "strMeasure8"
            case measure9 = "strMeasure9"
            case measure10 = "strMeasure10"
            case measure11 = "strMeasure11"
            case measure12 = "strMeasure12"
            case measure13 = "strMeasure13"
            case measure14 = "strMeasure14"
            case measure15 = "strMeasure15"
            case dateModified
        }
        
        var ingredients: [String] {
            Array(ingredientsAndMeasures.keys).compactMap { $0 }
        }
        
        var ingredientsAndMeasures: [String: String?] {
            var dict: [String: String?] = [:]
            dict.addIfKeyIsNotNull(ingredient1, measure1)
            dict.addIfKeyIsNotNull(ingredient2, measure2)
            dict.addIfKeyIsNotNull(ingredient3, measure3)
            dict.addIfKeyIsNotNull(ingredient4, measure4)
            dict.addIfKeyIsNotNull(ingredient5, measure5)
            dict.addIfKeyIsNotNull(ingredient6, measure6)
            dict.addIfKeyIsNotNull(ingredient7, measure7)
            dict.addIfKeyIsNotNull(ingredient8, measure8)
            dict.addIfKeyIsNotNull(ingredient9, measure9)
            dict.addIfKeyIsNotNull(ingredient10, measure10)
            dict.addIfKeyIsNotNull(ingredient11, measure11)
            dict.addIfKeyIsNotNull(ingredient12, measure12)
            dict.addIfKeyIsNotNull(ingredient13, measure13)
            dict.addIfKeyIsNotNull(ingredient14, measure14)
            dict.addIfKeyIsNotNull(ingredient15, measure15)
            
            return dict
        }
    }
}
