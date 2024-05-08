//
//  HomeViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation
import Combine
import CombineExt

protocol HomeViewModeling: ObservableObject {
    var cocktailViewModels: [CocktailViewModel] { get }
    var searchText: String { get set }
}

final class HomeViewModel: HomeViewModeling {
    
    // MARK: - Private properties
    
    private let cocktailService: CocktailServicing
    private let onFloatingButtonTapSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Internal properties
    
    @Published private(set) var cocktailViewModels: [CocktailViewModel] = []
    @Published var searchText: String = ""
    
    // MARK: - Init
    
    init(
        cocktailService: CocktailServicing = CocktailService()
    ) {
        self.cocktailService = cocktailService
        
        observe()
    }
    
    // MARK: - Private functions
    
    private func observe() {
        cocktailService.searchCocktails(withQuery: nil)
            // TODO: - remove ignore failure
            .ignoreFailure()
            .map { drinksResponse in
                drinksResponse.drinks.map {
                    CocktailViewModel(
                        id: $0.id,
                        title: $0.name,
                        subtitle: $0.ingredients.compactMap({ $0 }).joined(separator: ", "),
                        imageUrl: $0.thumbnailUrl
                    )
                }
            }
            .assign(to: &$cocktailViewModels)
    }
}
