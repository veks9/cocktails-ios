//
//  FilterViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation

final class FilterViewModel {
    let id: String
    let title: String
    var isSelected: Bool
    
    init(
        id: String,
        title: String,
        isSelected: Bool
    ) {
        self.id = id
        self.title = title
        self.isSelected = isSelected
    }
}
