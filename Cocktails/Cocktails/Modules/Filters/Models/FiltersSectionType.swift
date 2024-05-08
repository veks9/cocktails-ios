//
//  FiltersSectionType.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation

enum FiltersSectionType {
    case alcoholic
    case glass
    case category
    
    var title: String {
        switch self {
        case .alcoholic:
            "filters_alcoholic_section_title".localized()
        case .glass:
            "filters_glass_section_title".localized()
        case .category:
            "filters_category_section_title".localized()
        }
    }
}

extension FiltersSectionType: Hashable {
    static func == (lhs: FiltersSectionType, rhs: FiltersSectionType) -> Bool {
        switch (lhs, rhs) {
        case (.alcoholic, .alcoholic):
            return true
        case (.glass, .glass):
            return true
        case (.category, .category):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .alcoholic:
            hasher.combine("alcoholic")
        case .glass:
            hasher.combine("glass")
        case .category:
            hasher.combine("category")
        }
    }
}
