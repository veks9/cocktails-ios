//
//  CocktailViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

final class CocktailViewModel: Identifiable {
    let id: String
    let title: String
    let subtitle: String?
    let imageUrl: URL?
    
    init(
        id: String,
        title: String,
        subtitle: String?,
        imageUrl: URL?
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
    
    init(from model: Model.Drink) {
        self.id = model.id
        self.title = model.name
        self.subtitle = model.ingredients.compactMap({ $0 }).joined(separator: ", ")
        self.imageUrl = model.thumbnailUrl
    }
}

// MARK: - Hashable

extension CocktailViewModel: Hashable {
    static func == (lhs: CocktailViewModel, rhs: CocktailViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
