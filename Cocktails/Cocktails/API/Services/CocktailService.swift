//
//  CocktailService.swift
//  Cocktails
//
//  Created by Vedran Hernaus on 06.05.2024..
//

import Foundation
import Combine

protocol CocktailServicing {
    func searchCocktails(withQuery query: String?) -> Future<Model.Response<[Model.Drink]>, Model.APIError>
    func getCocktail(with id: String) -> AnyPublisher<Model.Drink?, Model.APIError>
    func getRandomCocktail() -> AnyPublisher<Model.Drink?, Model.APIError>
    func getAlcoholicFilters() -> Future<Model.Response<[Model.AlcoholicFilter]>, Model.APIError>
    func getCategoryFilters() -> Future<Model.Response<[Model.CategoryFilter]>, Model.APIError>
    func getGlassFilters() -> Future<Model.Response<[Model.GlassFilter]>, Model.APIError>
}

final class CocktailService: CocktailServicing {
    func searchCocktails(withQuery query: String?) -> Future<Model.Response<[Model.Drink]>, Model.APIError> {
        APIClient.shared.performRequest(SearchCocktailsRequest(searchQuery: query))
    }
    
    func getCocktail(with id: String) -> AnyPublisher<Model.Drink?, Model.APIError> {
        APIClient.shared.performRequest(GetCocktailDetailsRequest(id: id))
            .map { $0.data.first }
            .eraseToAnyPublisher()
    }
    
    func getRandomCocktail() -> AnyPublisher<Model.Drink?, Model.APIError> {
        APIClient.shared.performRequest(GetRandomCocktailDetailsRequest())
            .map { $0.data.first }
            .eraseToAnyPublisher()
    }
    
    func getAlcoholicFilters() -> Future<Model.Response<[Model.AlcoholicFilter]>, Model.APIError> {
        APIClient.shared.performRequest(GetAlcoholicFiltersRequest())
    }
    
    func getCategoryFilters() -> Future<Model.Response<[Model.CategoryFilter]>, Model.APIError> {
        APIClient.shared.performRequest(GetCategoryFiltersRequest())
    }
    
    func getGlassFilters() -> Future<Model.Response<[Model.GlassFilter]>, Model.APIError> {
        APIClient.shared.performRequest(GetGlassFiltersRequest())
    }
}
