//
//  FilterResultsViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import Foundation

protocol FilterResultsViewModeling: ObservableObject {
    var cocktailViewModels: [CocktailViewModel] { get }
    var isLoading: Bool { get }
}

final class FilterResultsViewModel: FilterResultsViewModeling {
    
    // MARK: - Private properties
    
    private let context: FilterResultsContext
    private let cocktailService: CocktailServicing
    
    // MARK: - Init
    
    init(
        context: FilterResultsContext,
        cocktailService: CocktailServicing = CocktailService()
    ) {
        self.context = context
        self.cocktailService = cocktailService
        
        observe()
    }
    
    // MARK: - Internal properties
    
    @Published private(set) var cocktailViewModels: [CocktailViewModel] = []
    @Published private(set) var isLoading: Bool = true
    
    // MARK: - Private functions
    
    private func observe() {
        cocktailService.filterCocktails(
            alcoholicFilter: context.selectedAlcoholicId,
            categoryFilter: context.selectedCategoryId,
            glassFilter: context.selectedGlassId
        )
        .ignoreFailure()
        .map { drinksResponse in
            drinksResponse.data.map {
                CocktailViewModel(from: $0)
            }
        }
        .handleEvents(receiveOutput: { [weak self] _ in
            self?.isLoading = false
        })
        .assign(to: &$cocktailViewModels)
    }
}
