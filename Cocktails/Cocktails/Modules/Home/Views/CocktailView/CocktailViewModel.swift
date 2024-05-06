//
//  CocktailViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation

final class CocktailViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL?
    
    init(
        title: String,
        subtitle: String,
        imageUrl: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
}
