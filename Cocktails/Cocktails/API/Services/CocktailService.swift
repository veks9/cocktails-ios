//
//  CocktailService.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation
import Combine

protocol CocktailServicing {
    func searchCocktails(withQuery query: String?) -> Future<Model.Drinks, Model.APIError>
    func getCocktail(with id: String) -> AnyPublisher<Model.Drink?, Model.APIError>
    func getRandomCocktail() -> AnyPublisher<Model.Drink?, Model.APIError>
}

final class CocktailService: CocktailServicing {
    func searchCocktails(withQuery query: String?) -> Future<Model.Drinks, Model.APIError> {
        APIClient.shared.performRequest(SearchCocktailsRequest(searchQuery: query))
    }
    
    func getCocktail(with id: String) -> AnyPublisher<Model.Drink?, Model.APIError> {
        APIClient.shared.performRequest(GetCocktailDetailsRequest(id: id))
            .map { $0.drinks.first }
            .eraseToAnyPublisher()
    }
    
    func getRandomCocktail() -> AnyPublisher<Model.Drink?, Model.APIError> {
        APIClient.shared.performRequest(GetRandomCocktailDetailsRequest())
            .map { $0.drinks.first }
            .eraseToAnyPublisher()
    }
}
