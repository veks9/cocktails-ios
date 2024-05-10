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
    var showError: Bool { get set }
    
    func onSearchBarFocusChange(_ focus: Bool)
}

final class HomeViewModel: HomeViewModeling {
    
    // MARK: - Private properties
    
    private let cocktailService: CocktailServicing
    private let isSearchFocusedSubject = CurrentValueSubject<Bool, Never>(false)
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(
        cocktailService: CocktailServicing = CocktailService()
    ) {
        self.cocktailService = cocktailService
        
        observe()
    }
    
    // MARK: - Internal properties
    
    @Published private(set) var cocktailViewModels: [CocktailViewModel] = []
    @Published var searchText = ""
    @Published private(set) var isLoading = true
    @Published private(set) var isFilterButtonShown = true
    @Published var showError = false
    
    // MARK: - Private functions
    
    private func observe() {
        Publishers.CombineLatest(
            $searchText.debounce(for: 0.2, scheduler: RunLoop.main),
            isSearchFocusedSubject
        )
        .setFailureType(to: Model.APIError.self)
        .flatMapLatest { [weak self] query, isSearchFocused -> AnyPublisher<[CocktailViewModel], Model.APIError> in
            guard let self else { return Just([]).setFailureType(to: Model.APIError.self).eraseToAnyPublisher() }
            if isSearchFocused, query.isEmpty {
                return Just([]).setFailureType(to: Model.APIError.self).eraseToAnyPublisher()
            } else {
                return cocktailService.searchCocktails(withQuery: query)
                    .map { drinksResponse in
                        let models = drinksResponse.data ?? []
                        return models.map {
                            CocktailViewModel(from: $0)
                        }
                    }
                    .eraseToAnyPublisher()
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
