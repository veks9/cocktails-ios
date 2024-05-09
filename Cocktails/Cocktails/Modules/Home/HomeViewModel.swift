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
    var isLoading: Bool { get }
    var isFilterButtonShown: Bool { get }
    
    func onSearchBarFocusChange(_ focus: Bool)
}

final class HomeViewModel: HomeViewModeling {
    
    // MARK: - Private properties
    
    private let cocktailService: CocktailServicing
    private let isSearchFocusedSubject = CurrentValueSubject<Bool, Never>(false)
    
    // MARK: - Init
    
    init(
        cocktailService: CocktailServicing = CocktailService()
    ) {
        self.cocktailService = cocktailService
        
        observe()
    }
    
    // MARK: - Internal properties
    
    @Published private(set) var cocktailViewModels: [CocktailViewModel] = []
    @Published var searchText: String = ""
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var isFilterButtonShown: Bool = true
    
    // MARK: - Private functions
    
    private func observe() {
        Publishers.CombineLatest(
            $searchText.debounce(for: 0.2, scheduler: RunLoop.main),
            isSearchFocusedSubject
        )
        .flatMapLatest { [weak self] query, isSearchFocused in
            guard let self else { return Just<[CocktailViewModel]>([]).eraseToAnyPublisher() }
            if isSearchFocused, query.isEmpty {
                return Just<[CocktailViewModel]>([]).eraseToAnyPublisher()
            } else {
                return cocktailService.searchCocktails(withQuery: query)
                    .ignoreFailure()
                    .map { drinksResponse in
                        drinksResponse.data.map {
                            CocktailViewModel(from: $0)
                        }
                    }
                    .eraseToAnyPublisher()
            }
        }
        .handleEvents(receiveOutput: { [weak self] _ in
            self?.isLoading = false
        })
        .assign(to: &$cocktailViewModels)
        
        Publishers.CombineLatest(
            $searchText,
            isSearchFocusedSubject
        )
        .map { searchText, isSearchFocused in
            searchText.isEmpty && !isSearchFocused
        }
        .assign(to: &$isFilterButtonShown)
    }
}

// MARK: - Internal funcitons

extension HomeViewModel {
    func onSearchBarFocusChange(_ focus: Bool) {
        isSearchFocusedSubject.send(focus)
    }
}
