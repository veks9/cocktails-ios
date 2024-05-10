//
//  FiltersViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 08.05.2024..
//

import Foundation
import Combine

protocol FiltersViewModeling: ObservableObject, Hashable, Identifiable {
    var dataSource: [FiltersSection] { get }
    var isResetButtonDisabled: Bool { get }
    var isFloatingButtonDisabled: Bool { get }
    var isLoading: Bool { get }
    var filterResultsViewModel: FilterResultsViewModel { get }
    
    func onAlcoholicFilterViewTap(with id: String)
    func onCategoryFilterViewTap(with id: String)
    func onGlassFilterViewTap(with id: String)
    func onResetButtonTap()
}

final class FiltersViewModel: FiltersViewModeling {
    
    // MARK: - Private properties
    
    private let cocktailService: CocktailServicing
    
    @Published private var selectedAlcoholicId: String?
    @Published private var selectedCategoryId: String?
    @Published private var selectedGlassId: String?

    // MARK: - Init

    init(cocktailService: CocktailServicing = CocktailService()) {
        self.cocktailService = cocktailService
        
        observe()
    }
    
    // MARK: - Internal properties
    
    @Published private(set) var dataSource: [FiltersSection] = []
    @Published private(set) var isResetButtonDisabled: Bool = true
    @Published private(set) var isFloatingButtonDisabled: Bool = true
    @Published private(set) var isLoading: Bool = true
    
    var filterResultsViewModel: FilterResultsViewModel {
        FilterResultsViewModel(
            context: FilterResultsContext(
                selectedAlcoholicId: selectedAlcoholicId,
                selectedCategoryId: selectedCategoryId,
                selectedGlassId: selectedGlassId
            )
        )
    }
    
    var selectedIds: AnyPublisher<(String?, String?, String?), Never> {
        Publishers.CombineLatest3(
            $selectedAlcoholicId,
            $selectedCategoryId,
            $selectedGlassId
        )
        .eraseToAnyPublisher()
    }
    
    // MARK: - Private functions
    
    private func observe() {
        selectedIds
        .map {
            $0.isEmptyOrNil && $1.isEmptyOrNil && $2.isEmptyOrNil
        }
        .assign(to: &$isResetButtonDisabled)
        
        selectedIds
        .map {
            $0.isEmptyOrNil && $1.isEmptyOrNil && $2.isEmptyOrNil
        }
        .assign(to: &$isFloatingButtonDisabled)
        
        Publishers.CombineLatest4(
            cocktailService.getAlcoholicFilters().ignoreFailure().map { $0.data },
            cocktailService.getCategoryFilters().ignoreFailure().map { $0.data },
            cocktailService.getGlassFilters().ignoreFailure().map { $0.data },
            selectedIds
        )
        .ignoreFailure()
        .map { [weak self] alcoholicFilters, categoryFilters, glassFilters, selectedIds in
            guard let self else { return [] }
            let selectedAlcoholicId = selectedIds.0
            let selectedCategoryId = selectedIds.1
            let selectedGlassId = selectedIds.2
            let alcoholicSection = createAlcoholicSection(from: alcoholicFilters, selectedId: selectedAlcoholicId)
            let categoriesSection = createCategoriesSection(from: categoryFilters, selectedId: selectedCategoryId)
            let glassesSection = createGlassesSection(from: glassFilters, selectedId: selectedGlassId)
            
            return [alcoholicSection, categoriesSection, glassesSection]
        }
        .handleEvents(receiveOutput: { [weak self] _ in
            self?.isLoading = false
        })
        .assign(to: &$dataSource)
    }
    
    private func createAlcoholicSection(from models: [Model.AlcoholicFilter], selectedId: String?) -> FiltersSection {
        FiltersSection(
            section: .alcoholic,
            items: getCells(from: models, selectedId: selectedId)
        )
    }
    
    private func getCells(from models: [Model.AlcoholicFilter], selectedId: String?) -> [FiltersCellType] {
        models
            .map { model in
                .filter(
                    FilterViewModel(
                        id: model.name,
                        title: model.name,
                        isSelected: selectedId == model.name
                    )
                )
        }
    }
    
    private func createCategoriesSection(from models: [Model.CategoryFilter], selectedId: String?) -> FiltersSection {
        FiltersSection(
            section: .category,
            items: getCells(from: models, selectedId: selectedId)
        )
    }
    
    private func getCells(from models: [Model.CategoryFilter], selectedId: String?) -> [FiltersCellType] {
        models
            .map { model in
                .filter(
                    FilterViewModel(
                        id: model.name,
                        title: model.name,
                        isSelected: selectedId == model.name
                    )
                )
        }
    }
    
    private func createGlassesSection(from models: [Model.GlassFilter], selectedId: String?) -> FiltersSection {
        FiltersSection(
            section: .glass,
            items: getCells(from: models, selectedId: selectedId)
        )
    }
    
    private func getCells(from models: [Model.GlassFilter], selectedId: String?) -> [FiltersCellType] {
        models
            .map { model in
                .filter(
                    FilterViewModel(
                        id: model.name,
                        title: model.name,
                        isSelected: selectedId == model.name
                    )
                )
            }
    }
}

// MARK: - Internal functions

extension FiltersViewModel {
    func onAlcoholicFilterViewTap(with id: String) {
        selectedAlcoholicId = id
    }
    
    func onCategoryFilterViewTap(with id: String) {
        selectedCategoryId = id
    }
    
    func onGlassFilterViewTap(with id: String) {
        selectedGlassId = id
    }
    
    func onResetButtonTap() {
        selectedAlcoholicId = nil
        selectedCategoryId = nil
        selectedGlassId = nil
    }
}

// MARK: - Identifiable

extension FiltersViewModel {
    var id: UUID {
        UUID()
    }
}

// MARK: - Hashable

extension FiltersViewModel {
    static func == (lhs: FiltersViewModel, rhs: FiltersViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
