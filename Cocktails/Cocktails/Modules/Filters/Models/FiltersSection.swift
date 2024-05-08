//
//  FiltersSection.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation

struct FiltersSection: Identifiable {
    var id = UUID()
    let section: FiltersSectionType
    let items: [FiltersCellType]
}
