//
//  Router.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import SwiftUI

final class Router: ObservableObject {
    
    enum Destination: Hashable {
        case filters(viewModel: FiltersViewModel)
        case cocktailDetails(viewModel: CocktailDetailsViewModel)
        case filterResults(viewModel: FilterResultsViewModel)
    }
    
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
