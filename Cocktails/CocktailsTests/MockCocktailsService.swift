//
//  MockCocktailsService.swift
//  CocktailsTests
//
//  Created by Vedran Hernaus on 10.05.2024..
//

import Foundation
import Combine
@testable import Cocktails

final class MockCocktailService: CocktailServicing {
    var mockSearchCocktailsResponse: Model.Response<[Model.Drink]>?
    
    func searchCocktails(withQuery query: String?) -> Future<Cocktails.Model.Response<[Cocktails.Model.Drink]>, Cocktails.Model.APIError> {
        Future { [weak self] promise in
            guard let self else { return }
            if let response = mockSearchCocktailsResponse {
                return promise(.success(response))
            } else {
                fatalError()
            }
        }
    }
    
    func getCocktail(with id: String) -> AnyPublisher<Cocktails.Model.Drink?, Cocktails.Model.APIError> {
        Just(mockSearchCocktailsResponse?.data?.first).setFailureType(to: Cocktails.Model.APIError.self).eraseToAnyPublisher()
    }
    
    func getRandomCocktail() -> AnyPublisher<Cocktails.Model.Drink?, Cocktails.Model.APIError> {
        Just(mockSearchCocktailsResponse?.data?.first).setFailureType(to: Cocktails.Model.APIError.self).eraseToAnyPublisher()
    }
    
    func getAlcoholicFilters() -> Future<Cocktails.Model.Response<[Cocktails.Model.AlcoholicFilter]>, Cocktails.Model.APIError> {
        Future { promise in
            promise(.success(Model.Response(data: [])))
        }
    }
    
    func getCategoryFilters() -> Future<Cocktails.Model.Response<[Cocktails.Model.CategoryFilter]>, Cocktails.Model.APIError> {
        Future { promise in
            promise(.success(Model.Response(data: [])))
        }
    }
    
    func getGlassFilters() -> Future<Cocktails.Model.Response<[Cocktails.Model.GlassFilter]>, Cocktails.Model.APIError> {
        Future { promise in
            promise(.success(Model.Response(data: [])))
        }
    }
    
    func filterCocktails(alcoholicFilter: String?, categoryFilter: String?, glassFilter: String?) -> Future<Cocktails.Model.Response<[Cocktails.Model.Drink]>, Cocktails.Model.APIError> {
        Future { promise in
            promise(.success(Model.Response(data: [])))
        }
    }
}
