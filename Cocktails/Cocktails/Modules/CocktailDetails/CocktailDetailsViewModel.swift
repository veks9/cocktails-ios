//
//  CocktailDetailsViewModel.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 07.05.2024..
//

import Combine
import SwiftUI

protocol CocktailDetailsViewModeling: ObservableObject {
    var categoryIconTitleViewModel: IconTitleViewModel? { get }
    var glassIconTitleViewModel: IconTitleViewModel? { get }
    var alcoholicTypeIconTitleViewModel: IconTitleViewModel? { get }
    var navigationTitle: String { get }
    var thumbnailUrl: URL? { get }
    var directions: String? { get }
    var lastModifiedFormatted: AttributedString? { get }
    var ingredientsAndMeasures: String? { get }
    var isLoading: Bool { get }
}

final class CocktailDetailsViewModel: CocktailDetailsViewModeling {
    
    // MARK: - Private properties
    
    private let context: CocktailDetailsContext
    private let cocktailService: CocktailServicing
    
    // MARK: - Init
    
    init(
        context: CocktailDetailsContext,
        cocktailService: CocktailServicing = CocktailService()
    ) {
        self.context = context
        self.cocktailService = cocktailService
        
        bindPublishers()
    }
    
    // MARK: - Private properties
    
    private lazy var model: AnyPublisher<Model.Drink, Never> = {
        var publisher: AnyPublisher<Model.Drink?, Model.APIError>
        switch context.fetchType {
        case .random:
            publisher = cocktailService.getRandomCocktail()
        case .id(let id):
            publisher = cocktailService.getCocktail(with: id)
        }
        
        return publisher
            .ignoreFailure()
            .compactMap({ $0 })
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .share(replay: 1)
            .eraseToAnyPublisher()
    }()
    
    // MARK: - Internal properties
    
    @Published private(set) var categoryIconTitleViewModel: IconTitleViewModel?
    @Published private(set) var glassIconTitleViewModel: IconTitleViewModel?
    @Published private(set) var alcoholicTypeIconTitleViewModel: IconTitleViewModel?
    @Published private(set) var navigationTitle: String = ""
    @Published private(set) var thumbnailUrl: URL?
    @Published private(set) var directions: String?
    @Published private(set) var lastModifiedFormatted: AttributedString?
    @Published private(set) var ingredientsAndMeasures: String?
    @Published private(set) var isLoading: Bool = true
    
    // MARK: - Private functions
    
    private func bindPublishers() {
        model
            .map { $0.name }
            .assign(to: &$navigationTitle)
        
        model
            .map { $0.thumbnailUrl }
            .assign(to: &$thumbnailUrl)
        
        model
            .map {
                guard let category = $0.category else { return nil }
                return IconTitleViewModel(
                    asset: Assets.category,
                    title: category
                )
            }
            .assign(to: &$categoryIconTitleViewModel)
        
        model
            .map {
                guard let glass = $0.glass else { return nil }
                return IconTitleViewModel(
                    asset: Assets.glass,
                    title: glass
                )
            }
            .assign(to: &$glassIconTitleViewModel)
        
        model
            .map {
                guard let alcoholic = $0.alcoholic else { return nil }
                return IconTitleViewModel(
                    asset: Assets.alcoholic,
                    title: alcoholic
                )
            }
            .assign(to: &$alcoholicTypeIconTitleViewModel)
        
        model
            .map { $0.instructions }
            .assign(to: &$directions)
        
        model
            .map { [weak self] model -> String? in
                guard let self, !model.ingredientsAndMeasures.isEmpty else { return nil }
                return createIngredientsAndMeasuresList(from: model.ingredientsAndMeasures)
            }
            .assign(to: &$ingredientsAndMeasures)
        
        model
            .map({ [weak self] model in
                guard let self else { return nil }
                return createLastModifiedAttributedString(from: model.dateModified)
            })
            .assign(to: &$lastModifiedFormatted)
    }
    
    private func createIngredientsAndMeasuresList(from ingredientsAndMeasures: [String: String?]) -> String {
        ingredientsAndMeasures.reduce("") { partialResult, entry in
            var mutableString = "• "
            if let value = entry.value {
                mutableString.append("\(value) ")
            }
            mutableString.append("\(entry.key)\n")
            return partialResult + mutableString
        }
        .trimmingCharacters(in: .whitespacesAndNewlines)

    }
    
    private func createLastModifiedAttributedString(from dateModified: Date?) -> AttributedString? {
        guard let dateModified else { return nil }
        let relativeDate = dateModified.toRelativeDate()
        let localizedString = "cocktail_details_directions_last_modified_title".localized()
        let combinedString = "\(localizedString) \(relativeDate)"
        let attributedString = NSMutableAttributedString(string: combinedString)
        
        let localizedStringRange = (combinedString as NSString).range(of: localizedString)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .semibold), range: localizedStringRange)
        
        let relativeDateRange = (combinedString as NSString).range(of: relativeDate)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: relativeDateRange)
        
        return AttributedString(attributedString)
    }
}
