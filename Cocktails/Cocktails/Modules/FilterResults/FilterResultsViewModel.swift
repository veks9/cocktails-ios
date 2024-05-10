//
//  FilterResultsViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 09.05.2024..
//

import Foundation
import Combine

protocol FilterResultsViewModeling: ObservableObject, Identifiable, Hashable {
    var cocktailViewModels: [CocktailViewModel] { get }
    var isLoading: Bool { get }
    var showError: Bool { get set }
}

final class FilterResultsViewModel: FilterResultsViewModeling {
    
    // MARK: - Private properties
    
    private let context: FilterResultsContext
    private let cocktailService: CocktailServicing
    private var cancellables = Set<AnyCancellable>()
    
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
    @Published private(set) var isLoading = true
    @Published var showError = false
    
    // MARK: - Private functions
    
    private func observe() {
        cocktailService.filterCocktails(
            alcoholicFilter: context.selectedAlcoholicId,
            categoryFilter: context.selectedCategoryId,
            glassFilter: context.selectedGlassId
        )
        .map { drinksResponse in
            let models = drinksResponse.data ?? []
            return models.map {
                CocktailViewModel(from: $0)
            }
        }
        .sink(receiveCompletion: { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .finished:
                break
            case .failure:
                isLoading = false
                showError = true
            }
        }, receiveValue: { [weak self] cocktailViewModels in
            guard let self else { return }
            isLoading = false
            self.cocktailViewModels = cocktailViewModels
        })
        .store(in: &cancellables)
    }
}

// MARK: - Identifiable

extension FilterResultsViewModel {
    var id: UUID {
        UUID()
    }
}

// MARK: - Hashable

extension FilterResultsViewModel {
    static func == (lhs: FilterResultsViewModel, rhs: FilterResultsViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
