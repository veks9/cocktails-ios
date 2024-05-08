//
//  FiltersCellType.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation

enum FiltersCellType {
    case filter(FilterViewModel)
}

extension FiltersCellType: Hashable, Identifiable  {
    var id: UUID {
        UUID()
    }
    
    static func == (lhs: FiltersCellType, rhs: FiltersCellType) -> Bool {
        switch (lhs, rhs) {
        case (.filter(let lhsViewModel), .filter(let rhsViewModel)):
            return lhsViewModel.id == rhsViewModel.id && lhsViewModel.isSelected && rhsViewModel.isSelected
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .filter(let cellViewModel):
            hasher.combine("filter-\(cellViewModel.id)")
        }
    }
}
