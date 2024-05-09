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
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
