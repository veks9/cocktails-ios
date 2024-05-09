//
//  Drink.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

extension Model {
    struct Drink: Decodable {
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
        
        init(
            id: String,
            name: String,
            category: String? = nil,
            alcoholic: String? = nil,
            glass: String? = nil,
            instructions: String? = nil,
            thumbnailUrl: URL? = nil,
            ingredient1: String? = nil,
            ingredient2: String? = nil,
            ingredient3: String? = nil,
            ingredient4: String? = nil,
            ingredient5: String? = nil,
            ingredient6: String? = nil,
            ingredient7: String? = nil,
            ingredient8: String? = nil,
            ingredient9: String? = nil,
            ingredient10: String? = nil,
            ingredient11: String? = nil,
            ingredient12: String? = nil,
            ingredient13: String? = nil,
            ingredient14: String? = nil,
            ingredient15: String? = nil,
            measure1: String? = nil,
            measure2: String? = nil,
            measure3: String? = nil,
            measure4: String? = nil,
            measure5: String? = nil,
            measure6: String? = nil,
            measure7: String? = nil,
            measure8: String? = nil,
            measure9: String? = nil,
            measure10: String? = nil,
            measure11: String? = nil,
            measure12: String? = nil,
            measure13: String? = nil,
            measure14: String? = nil,
            measure15: String? = nil,
            dateModified: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.category = category
            self.alcoholic = alcoholic
            self.glass = glass
            self.instructions = instructions
            self.thumbnailUrl = thumbnailUrl
            self.ingredient1 = ingredient1
            self.ingredient2 = ingredient2
            self.ingredient3 = ingredient3
            self.ingredient4 = ingredient4
            self.ingredient5 = ingredient5
            self.ingredient6 = ingredient6
            self.ingredient7 = ingredient7
            self.ingredient8 = ingredient8
            self.ingredient9 = ingredient9
            self.ingredient10 = ingredient10
            self.ingredient11 = ingredient11
            self.ingredient12 = ingredient12
            self.ingredient13 = ingredient13
            self.ingredient14 = ingredient14
            self.ingredient15 = ingredient15
            self.measure1 = measure1
            self.measure2 = measure2
            self.measure3 = measure3
            self.measure4 = measure4
            self.measure5 = measure5
            self.measure6 = measure6
            self.measure7 = measure7
            self.measure8 = measure8
            self.measure9 = measure9
            self.measure10 = measure10
            self.measure11 = measure11
            self.measure12 = measure12
            self.measure13 = measure13
            self.measure14 = measure14
            self.measure15 = measure15
            self.dateModified = dateModified
        }
        
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
